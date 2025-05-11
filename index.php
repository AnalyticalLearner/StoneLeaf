<?php
session_start();

/**
 * StoneLeaf Directory Listing Script - Optimized Version
 * System Requirements:
 * - PHP >= 7.1
 * - GD Library for image previews
 * - ZipArchive extension for unzip functionality
 */

class DirectoryListing {
    public $startDirectory = '.';
    public $pageTitle = 'A StoneLeaf Library';
    public $includeUrl = false;
    public $directoryUrl = 'http://yoursite.com/main-directory-name-here/';
    public $showSubDirectories = true;
    public $openLinksInNewTab = false;
    public $showThumbnails = true;
    public $enableDirectoryCreation = true;
    public $enableUploads = false;
    public $enableMultiFileUploads = false;
    public $overwriteOnUpload = false;
    public $enableFileDeletion = false;
    public $enableDirectoryDeletion = false;

    private function formatSize($bytes) {
        if ($bytes >= 1073741824) return number_format($bytes / 1073741824, 2) . ' GB';
        if ($bytes >= 1048576) return number_format($bytes / 1048576, 2) . ' MB';
        if ($bytes >= 1024) return number_format($bytes / 1024, 2) . ' KB';
        return $bytes . ' B';
    }

    private function getFileIcon($filename) {
        $ext = strtolower(pathinfo($filename, PATHINFO_EXTENSION));
        return match($ext) {
            'jpg', 'jpeg', 'png', 'gif', 'bmp', 'svg', 'webp' => '🖼️',
            'zip', 'rar', 'tar', 'gz', '7z' => '📦',
            'pdf' => '📕',
            'doc', 'docx', 'odt' => '📄',
            'xls', 'xlsx', 'csv' => '📊',
            'ppt', 'pptx' => '📈',
            'mp3', 'wav', 'ogg' => '🎵',
            'mp4', 'mkv', 'avi' => '🎞️',
            'txt', 'md', 'log' => '📃',
            default => '📄',
        };
    }

    public function render() {
        $subDir = $_GET['dir'] ?? '';
        $sort = $_GET['sort'] ?? 'name';
        $filter = strtolower($_GET['filter'] ?? '');
        $sanitizedDir = str_replace(['..', "\0"], '', $subDir);
        $directory = realpath($this->startDirectory . DIRECTORY_SEPARATOR . $sanitizedDir);

        if (!$directory || strpos($directory, realpath($this->startDirectory)) !== 0) {
            die("Invalid directory");
        }

        $relativePath = str_replace(realpath($_SERVER['DOCUMENT_ROOT']), '', $directory);
        $items = array_diff(scandir($directory), ['.', '..']);

        if ($filter !== '') {
            $items = array_filter($items, fn($item) => stripos($item, $filter) !== false);
        }

        $sortFunc = match ($sort) {
            'size' => fn($a, $b) => filesize("$directory/$a") <=> filesize("$directory/$b"),
            'date' => fn($a, $b) => filemtime("$directory/$b") <=> filemtime("$directory/$a"),
            default => function($a, $b) use ($directory) {
                $aPath = "$directory/$a";
                $bPath = "$directory/$b";
                if (is_dir($aPath) && !is_dir($bPath)) return -1;
                if (!is_dir($aPath) && is_dir($bPath)) return 1;
                return strcasecmp($a, $b);
            },
        };

        usort($items, $sortFunc);

        echo "<html><head><title>{$this->pageTitle}</title>
        <style>
            body { display: flex; flex-direction: column; min-height: 100vh; margin: 0; padding: 0 20px; font-family: sans-serif; }
            footer { margin-top: auto; border-top: 1px solid #ccc; padding: 1em 0; text-align: center; }
        </style>
        </head><body>";

        echo "<h1>{$this->pageTitle}</h1>";

        echo '<form method="get">';
        echo '<input type="hidden" name="dir" value="' . htmlspecialchars($sanitizedDir) . '">';
        echo '<input type="text" name="filter" value="' . htmlspecialchars($filter) . '" placeholder="Search files">';
        echo '<input type="submit" value="Filter">';
        echo '</form>';

        $crumbs = explode('/', trim($sanitizedDir, '/'));
        echo '<nav><a href="?">Home</a>';
        $crumbPath = '';
        foreach ($crumbs as $crumb) {
            if ($crumb === '') continue;
            $crumbPath .= "/$crumb";
            echo " / <a href='?dir=" . urlencode(trim($crumbPath, '/')) . "'>$crumb</a>";
        }
        echo '</nav>';

        echo "<table border='1' cellpadding='4' cellspacing='0'><thead><tr>";
        echo "<th><a href='?dir=" . urlencode($sanitizedDir) . "&sort=name&filter=$filter'>Name</a></th>";
        echo "<th><a href='?dir=" . urlencode($sanitizedDir) . "&sort=size&filter=$filter'>Size</a></th>";
        echo "<th><a href='?dir=" . urlencode($sanitizedDir) . "&sort=date&filter=$filter'>Modified</a></th>";
        echo "</tr></thead><tbody>";

        foreach ($items as $item) {
            $fullPath = "$directory/$item";
            $icon = is_dir($fullPath) ? "📁" : $this->getFileIcon($item);
            $linkPath = $sanitizedDir ? "$sanitizedDir/$item" : $item;
            $link = is_dir($fullPath) ? "?dir=" . urlencode($linkPath) : htmlspecialchars($linkPath);
            $size = is_file($fullPath) ? $this->formatSize(filesize($fullPath)) : '-';
            $modified = date("Y-m-d H:i", filemtime($fullPath));
            echo "<tr><td>$icon <a href='$link'>$item</a></td><td>$size</td><td>$modified</td></tr>";
        }

        echo "</tbody></table>";

        echo "<footer>";
        echo "<p><strong>A StoneLeaf Library</strong></p>";
        echo "<p>Date: <script>document.write(new Date().toLocaleDateString());</script></p>";
        echo "<p><a href='https://stoneleaflibrary.example.com'>Visit StoneLeaf on GitHub</a></p>";
        echo "</footer>";

        echo "</body></html>";
    }
}

$listing = new DirectoryListing();
$listing->render();
