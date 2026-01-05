Return-Path: <cgroups+bounces-12921-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEBECF381E
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 13:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D88030F8937
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAC6335086;
	Mon,  5 Jan 2026 12:21:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F7B33A703;
	Mon,  5 Jan 2026 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615696; cv=none; b=MAGR8cSsJFIIgY+z437dCeJLy8AsBjNiqBPZOgluRvpworCCrkHgNWI8HIrTiF28H7HJouHUrVmEPCGMbn89RX8pzr6T00sqlNE2DoWQ8KMSAvatLo7GE+eu+g/UCUSoeARfUhEJl7yaNS7kgxuMvD8T3BATrKvrjnwgCojhgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615696; c=relaxed/simple;
	bh=sgUt9SfzxmD4cJXLwXbCUuzYHOvkpFkxrwHQnzWNxXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7YYmCSSosChmUqwuRFWyaCro247VUBL+ibAe53fXhUtWZu6afXeN/NdzeF+N+hTamz5KF8jYu29+CGU3fQiqRHDASfTCUPrJ1XU2DyGDh6XjsY5NgTEDVvFIXvnmfvBF0gr0m0iH8rKp1eb+qWazdhF+q2gnt+OzhvR6FUjWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dlD0F6KVZzYQtgX;
	Mon,  5 Jan 2026 20:20:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AD3764058A;
	Mon,  5 Jan 2026 20:21:28 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBXBvfFrFtpghzhCg--.64977S2;
	Mon, 05 Jan 2026 20:21:26 +0800 (CST)
Message-ID: <0b8ea26f-71f7-4f6d-b0d6-7d42e087a7ed@huaweicloud.com>
Date: Mon, 5 Jan 2026 20:21:24 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 0/7] mm/mglru: remove memcg lru
To: Kairui Song <ryncsn@gmail.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, corbet@lwn.net, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 zhengqi.arch@bytedance.com, mkoutny@suse.com, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, lujialin4@huawei.com
References: <20251224073032.161911-1-chenridong@huaweicloud.com>
 <CAMgjq7DQmdoQKZeFjpnYQ4wgMx3j-Lu7na+Ghs_Dh=Rq36MDOw@mail.gmail.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <CAMgjq7DQmdoQKZeFjpnYQ4wgMx3j-Lu7na+Ghs_Dh=Rq36MDOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXBvfFrFtpghzhCg--.64977S2
X-Coremail-Antispam: 1UD129KBjvAXoWfCF1DArW5uF1Utr1fCr1DAwb_yoW5Zw4UCo
	Wxtw1UuFs8W3s8Aw1vyw43WF15CF18Xws5uw1Dtr40k3W3Gws5A3Z3W3W7Kw45ZrWSya97
	Zrs8X3WrJ3yxGF1xn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYc7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUIa0PDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/28 1:49, Kairui Song wrote:
> On Wed, Dec 24, 2025 at 3:56 PM Chen Ridong <chenridong@huaweicloud.com> wrote:
>>
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The memcg LRU was introduced to improve scalability in global reclaim,
>> but its implementation has grown complex and can cause performance
>> regressions when creating many memory cgroups [1].
>>
>> This series implements mem_cgroup_iter with a reclaim cookie in
>> shrink_many() for global reclaim, following the pattern already used in
>> shrink_node_memcgs(), an approach suggested by Johannes [1]. The new
>> design maintains good fairness across cgroups by preserving iteration
>> state between reclaim passes.
>>
>> Testing was performed using the original stress test from Yu Zhao [2] on a
>> 1 TB, 4-node NUMA system. The results show:
>>
>>     pgsteal:
>>                                         memcg LRU    memcg iter
>>     stddev(pgsteal) / mean(pgsteal)     106.03%       93.20%
>>     sum(pgsteal) / sum(requested)        98.10%       99.28%
>>
>>     workingset_refault_anon:
>>                                         memcg LRU    memcg iter
>>     stddev(refault) / mean(refault)     193.97%      134.67%
>>     sum(refault)                       1,963,229    2,027,567
> 
> Hi Ridong,
> 
> Thanks for helping simplify the code, I would also like to see it get simpler.
> 
> But refault isn't what the memcg LRU is trying to prevent, memcg LRU
> is intended to reduce the overhead of reclaim. If there are multiple
> memcg running, the memcg LRU helps to scale up and reclaim the least
> reclaimed one and hence reduce the total system time spent on
> eviction.
> 
> That test you used was only posted to show that memcg LRU is
> effective. The scalability test is posted elsewhere, both from Yu:
> https://lore.kernel.org/all/20221220214923.1229538-1-yuzhao@google.com/
> https://lore.kernel.org/all/20221221000748.1374772-1-yuzhao@google.com/
> 
> I'm not entirely sure the performance impact of this series on that,
> but I think this test postes here doesn't really prove that. Just my
> two cents.

Thank you for the reminder.

I spent some time running the test:
https://lore.kernel.org/all/20221220214923.1229538-1-yuzhao@google.com/

Sadly, changing to iter has indeed led to a regression (results from a 2-hour run).
I also tried using the user cookie approach for kswapd, but it did not achieve results comparable to
MGLRU.

Throughput (number of requests)       MGLRU 	   Iter      Change
---------------------------------------------------------------------
Total                                 2160190      1267404    -41%


Hardware
========
[root@localhost ~]# lscpu
Architecture:                         aarch64
CPU op-mode(s):                       64-bit
Byte Order:                           Little Endian
CPU(s):                               128
On-line CPU(s) list:                  0-127
Thread(s) per core:                   1
Core(s) per socket:                   64
Socket(s):                            2
NUMA node(s):                         4
Model:                                0
Stepping:                             0x1
Frequency boost:                      disabled
CPU max MHz:                          2600.0000
CPU min MHz:                          200.0000
BogoMIPS:                             200.00
L1d cache:                            8 MiB
L1i cache:                            8 MiB
L2 cache:                             64 MiB
L3 cache:                             128 MiB
NUMA node0 CPU(s):                    0-31
NUMA node1 CPU(s):                    32-63
NUMA node2 CPU(s):                    64-95
NUMA node3 CPU(s):                    96-127
Vulnerability Gather data sampling:   Not affected
Vulnerability Itlb multihit:          Not affected
Vulnerability L1tf:                   Not affected
Vulnerability Mds:                    Not affected
Vulnerability Meltdown:               Not affected
Vulnerability Mmio stale data:        Not affected
Vulnerability Reg file data sampling: Not affected
Vulnerability Retbleed:               Not affected
Vulnerability Spec rstack overflow:   Not affected
Vulnerability Spec store bypass:      Not affected
Vulnerability Spectre v1:             Mitigation; __user pointer sanitization
Vulnerability Spectre v2:             Mitigation; CSV2, but not BHB
Vulnerability Srbds:                  Not affected
Vulnerability Tsa:                    Not affected
Vulnerability Tsx async abort:        Not affected
Flags:                                fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp
asimdhp cpuid asimdrdm jscvt fcma dcpop asimddp
                                       asimdfhm
[root@localhost ~]# numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
node 0 size: 257576 MB
node 0 free: 251580 MB
node 1 cpus: 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60
61 62 63
node 1 size: 258002 MB
node 1 free: 255859 MB
node 2 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92
93 94 95
node 2 size: 258043 MB
node 2 free: 255941 MB
node 3 cpus: 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118
119 120 121 122 123 124 125 126 127
node 3 size: 254967 MB
node 3 free: 250749 MB
node distances:
node   0   1   2   3
  0:  10  12  20  22
  1:  12  10  22  24
  2:  20  22  10  12
  3:  22  24  12  10

Software: Base on: 7eb60a75f521 ("Add linux-next specific files for 20251219")
========
[root@localhost ~]# node -v
v12.18.4
[root@localhost ~]# chromedriver -v
ChromeDriver 133.0.6943.141 (2a5d6da0d6165d7b107502095a937fe7704fcef6-refs/branch-heads/6943@{#1912})
[root@localhost ~]# python3 -c "import selenium; print(selenium.__version__)"
4.39.0

swaps created by:
```
fallocate -l 256G /home/swapfile1
chmod 600 /home/swapfile1
mkswap /home/swapfile1
swapon /home/swapfile1

fallocate -l 256G /home/swapfile2
chmod 600 /home/swapfile2
mkswap /home/swapfile2
swapon /home/swapfile2
```

Procedure
=========
```
[root@localhost kswapd]# cat server.js
const chunks = 16;
const size = 1024 * 1024 * 512;
const stride = 512;

const bufs = [];

for (let i = 0; i < chunks; i++) {
    bufs[i] = Buffer.alloc(size);
}

const http = require('http');

const server = http.createServer(function(req, res) {
    if (req.url != '/') {
        res.writeHead(404);
        res.end();
        return;
    }

    const rand = Math.floor(Math.random() * chunks);

    const buf = bufs[rand];
    for (let i = 0; i < buf.length; i += stride) {
        buf[i] = i;
    }

    const html = `<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<link rel="icon" href="data:,">
<title>memory test</title>
</head>
<body>
<div id="size">${buf.length}</div>
</body>
</html>`;

    res.writeHead(200, {'Content-Type': 'text/html'});
    res.end(html);
}).listen(process.argv[2]);

function exit(sig) {
    server.close(function() {
        process.exit(0);
    });
}

process.on('SIGINT', exit);
```


```
[root@localhost kswapd]# cat client.py
import signal
import sys
import time
import os
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By

# Clear proxy settings
os.environ.update({
    'http_proxy': '',
    'https_proxy': '',
    'HTTP_PROXY': '',
    'HTTPS_PROXY': ''
})

secs = [0, 1, 2, 4, 8, 16, 32, 64, 128]
hist = dict()

js = '''
const chunks = 4;
const size = 1024 * 128;
const stride = 128;

const rand = Math.floor(Math.random() * chunks);

const buf = new BigInt64Array(size * (chunks + 1));
for (let i = 0; i < buf.length; i += stride) {
    buf[i] = BigInt(i);
}

document.getElementById("size").innerHTML = "0";

return buf.length;
'''


def stop(sig, stack):
    raise KeyboardInterrupt

signal.signal(signal.SIGINT, stop)

def setup_driver():
    """Configure and create WebDriver"""
    options = Options()

    # Specify chromium binary path
    chromium_path = '/usr/bin/chromium-browser'
    if os.path.exists(chromium_path):
        options.binary_location = chromium_path
    else:
        # Try other possible paths
        for path in ['/usr/bin/chromium', '/usr/bin/google-chrome', '/usr/bin/google-chrome-stable']:
            if os.path.exists(path):
                options.binary_location = path
                break

    # Required arguments
    options.add_argument('--no-sandbox')
    options.add_argument('--headless')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--disable-gpu')
    options.add_argument('--window-size=1920,1080')

    # Specify chromedriver path
    chromedriver_path = '/usr/bin/chromedriver'
    if not os.path.exists(chromedriver_path):
        # Try to find it
        import subprocess
        result = subprocess.run(['which', 'chromedriver'], capture_output=True, text=True)
        if result.returncode == 0:
            chromedriver_path = result.stdout.strip()
        else:
            raise FileNotFoundError("chromedriver not found")

    print(f"Using chromedriver: {chromedriver_path}")
    print(f"Using browser: {options.binary_location}")

    service = Service(executable_path=chromedriver_path)
    driver = webdriver.Chrome(service=service, options=options)

    return driver

try:
    # Create driver
    driver = setup_driver()
    driver.set_script_timeout(600)
    driver.set_page_load_timeout(600)

    port = sys.argv[1] if len(sys.argv) > 1 else '8000'
    url = f'http://127.0.0.1:{port}'
    print(f"Accessing: {url}")

    driver.get(url)

    # Initialize hist
    for sec in secs:
        hist[sec] = 0

    print("Starting test... (Press Ctrl+C to stop)")

    while True:
        try:
            start = time.time()

            driver.refresh()

            # Use new find_element method
            size_element = driver.find_element(By.ID, 'size')
            size = int(size_element.text)
            assert size > 0

            size = driver.execute_script(js)
            assert size > 0

            elapsed = time.time() - start

            for sec in reversed(secs):
                if elapsed >= sec:
                    hist[sec] += 1
                    break

            # Print progress every 100 iterations
            total = sum(hist.values())
            if total % 100 == 0:
                print(f"Progress: {total} iterations")

        except Exception as e:
            # On exception, count as 128 seconds and retry
            hist[128] += 1
            print(f"client:{port} exception: {type(e).__name__}")
            # Wait and retry
            time.sleep(1)
            continue

except KeyboardInterrupt:
    print('client:', sys.argv[1] if len(sys.argv) > 1 else '8000',
          'total: %6d,' % sum(hist.values()),
          ', '.join('%d: %6d' % (k, v) for k, v in hist.items()))
finally:
    if 'driver' in locals():
        driver.quit()
```

```
[root@localhost kswapd]# cat js_benchmark.sh
echo 0 >/proc/sys/kernel/numa_balancing

nodes=4
memcgs=32

run() {
    trap 'wait' SIGINT

    memcg=$1
    path=/sys/fs/cgroup/memcg$memcg

    mkdir $path
    echo $BASHPID >$path/cgroup.procs

    for ((node = 0; node < $nodes; node++)); do
        port=$((nodes * memcg + node + 8000))

        numactl -N $node -m $node node server.js $port &
    done

    sleep 60

    for ((node = 0; node < $nodes; node++)); do
        port=$((nodes * memcg + node + 8000))

        numactl -N $node -m $node python3 client.py $port &
    done

    wait
}

for ((memcg = 0; memcg < $memcgs; memcg++)); do
    run $memcg &
done

sleep $((2 * 60 * 60))
trap 'wait' SIGINT
kill -INT 0
```

Results(run 2h)
=======
MGLRU
------
client: 8000 total:  23457, 0:  23105, 1:     98, 2:     66, 4:     83, 8:     80, 16:      9, 32:
  11, 64:      4, 128:      1
client: 8001 total:  21003, 0:  20731, 1:     71, 2:     56, 4:     62, 8:     49, 16:     15, 32:
   7, 64:      5, 128:      7
client: 8002 total:    770, 0:    665, 1:     14, 2:     10, 4:     11, 8:      7, 16:      9, 32:
   8, 64:      8, 128:     38
client: 8003 total:  21803, 0:  21392, 1:    100, 2:     85, 4:     91, 8:     93, 16:     31, 32:
  10, 64:      1, 128:      0
client: 8004 total:  22169, 0:  21853, 1:     80, 2:     63, 4:     75, 8:     66, 16:     20, 32:
   6, 64:      2, 128:      4
client: 8005 total:  21955, 0:  21648, 1:     68, 2:     59, 4:     67, 8:     70, 16:     34, 32:
   5, 64:      0, 128:      4
client: 8006 total:    533, 0:    400, 1:     27, 2:     17, 4:     10, 8:     11, 16:      7, 32:
  14, 64:     12, 128:     35
client: 8007 total:  22027, 0:  21659, 1:     77, 2:     78, 4:     96, 8:     66, 16:     41, 32:
   9, 64:      0, 128:      1
client: 8008 total:  23342, 0:  23012, 1:     91, 2:     62, 4:     74, 8:     66, 16:     25, 32:
   6, 64:      4, 128:      2
client: 8009 total:  19759, 0:  19502, 1:     71, 2:     45, 4:     58, 8:     42, 16:     21, 32:
   8, 64:      4, 128:      8
client: 8010 total:  22769, 0:  22468, 1:     76, 2:     63, 4:     66, 8:     48, 16:     29, 32:
  10, 64:      4, 128:      5
client: 8011 total:  20974, 0:  20663, 1:     79, 2:     69, 4:     61, 8:     54, 16:     31, 32:
  10, 64:      1, 128:      6
client: 8012 total:   6262, 0:   6101, 1:     45, 2:     35, 4:     16, 8:      9, 16:      5, 32:
   7, 64:     14, 128:     30
client: 8013 total:   6448, 0:   6249, 1:     53, 2:     42, 4:     23, 8:     27, 16:     12, 32:
   6, 64:      3, 128:     33
client: 8014 total:  22817, 0:  22433, 1:    102, 2:     72, 4:     89, 8:     76, 16:     34, 32:
   6, 64:      4, 128:      1
client: 8015 total:  19266, 0:  18920, 1:    108, 2:     77, 4:     66, 8:     52, 16:     25, 32:
   6, 64:      2, 128:     10
client: 8016 total:  23059, 0:  22733, 1:     97, 2:     64, 4:     73, 8:     57, 16:     23, 32:
   8, 64:      1, 128:      3
client: 8017 total:  21188, 0:  20906, 1:     82, 2:     62, 4:     53, 8:     50, 16:     19, 32:
   6, 64:      0, 128:     10
client: 8018 total:  12347, 0:  12140, 1:     59, 2:     39, 4:     33, 8:     29, 16:     12, 32:
  10, 64:      3, 128:     22
client: 8019 total:   3276, 0:   3121, 1:     35, 2:     28, 4:     16, 8:     17, 16:      7, 32:
   7, 64:      3, 128:     42
client: 8020 total:  15479, 0:  15203, 1:     87, 2:     58, 4:     45, 8:     44, 16:     14, 32:
  10, 64:      2, 128:     16
client: 8021 total:   9592, 0:   9348, 1:     71, 2:     48, 4:     42, 8:     29, 16:     17, 32:
   9, 64:      4, 128:     24
client: 8022 total:  17776, 0:  17462, 1:     98, 2:     66, 4:     47, 8:     58, 16:     22, 32:
   8, 64:      5, 128:     10
client: 8023 total:  21720, 0:  21323, 1:    113, 2:     87, 4:     87, 8:     52, 16:     41, 32:
  16, 64:      1, 128:      0
client: 8024 total:  23306, 0:  22929, 1:    128, 2:     73, 4:     67, 8:     71, 16:     21, 32:
  14, 64:      3, 128:      0
client: 8025 total:    186, 0:     98, 1:      8, 2:      3, 4:      5, 8:     10, 16:      8, 32:
   3, 64:      5, 128:     46
client: 8026 total:  23484, 0:  23067, 1:    115, 2:     73, 4:    102, 8:     81, 16:     36, 32:
   9, 64:      1, 128:      0
client: 8027 total:  21944, 0:  21598, 1:     86, 2:     48, 4:     90, 8:     67, 16:     44, 32:
   6, 64:      5, 128:      0
client: 8028 total:  22970, 0:  22616, 1:     96, 2:     84, 4:     61, 8:     69, 16:     32, 32:
  10, 64:      1, 128:      1
client: 8029 total:  10464, 0:  10247, 1:     79, 2:     39, 4:     27, 8:     24, 16:      9, 32:
  10, 64:      3, 128:     26
client: 8030 total:  22565, 0:  22158, 1:     99, 2:     99, 4:     94, 8:     76, 16:     27, 32:
   7, 64:      2, 128:      3
client: 8031 total:  22004, 0:  21672, 1:     93, 2:     73, 4:     71, 8:     51, 16:     29, 32:
   8, 64:      4, 128:      3
client: 8032 total:  11542, 0:  11317, 1:     52, 2:     54, 4:     50, 8:     25, 16:      9, 32:
   8, 64:      6, 128:     21
client: 8033 total:  15315, 0:  15086, 1:     66, 2:     43, 4:     37, 8:     38, 16:     18, 32:
   8, 64:      3, 128:     16
client: 8034 total:  19827, 0:  19434, 1:    128, 2:     82, 4:     78, 8:     60, 16:     29, 32:
   5, 64:      5, 128:      6
client: 8035 total:  17247, 0:  16986, 1:     73, 2:     54, 4:     67, 8:     34, 16:      9, 32:
   4, 64:      4, 128:     16
client: 8036 total:  17389, 0:  17122, 1:     95, 2:     57, 4:     49, 8:     31, 16:     13, 32:
   3, 64:      2, 128:     17
client: 8037 total:    108, 0:     46, 1:      0, 2:      1, 4:      2, 8:      0, 16:      0, 32:
   1, 64:      3, 128:     55
client: 8038 total:  23297, 0:  22896, 1:    102, 2:     92, 4:     94, 8:     73, 16:     28, 32:
   9, 64:      1, 128:      2
client: 8039 total:  10108, 0:   9877, 1:     71, 2:     53, 4:     37, 8:     22, 16:      9, 32:
   7, 64:      4, 128:     28
client: 8040 total:  21865, 0:  21514, 1:     77, 2:     67, 4:     93, 8:     71, 16:     32, 32:
   8, 64:      2, 128:      1
client: 8041 total:  21116, 0:  20800, 1:     89, 2:     55, 4:     68, 8:     61, 16:     29, 32:
   8, 64:      1, 128:      5
client: 8042 total:  19846, 0:  19459, 1:     94, 2:     86, 4:     80, 8:     76, 16:     35, 32:
   8, 64:      6, 128:      2
client: 8043 total:  19000, 0:  18682, 1:     95, 2:     72, 4:     76, 8:     37, 16:     19, 32:
   5, 64:      6, 128:      8
client: 8044 total:   5892, 0:   5730, 1:     40, 2:     33, 4:     16, 8:     18, 16:     12, 32:
   1, 64:     10, 128:     32
client: 8045 total:  17379, 0:  17066, 1:     84, 2:     57, 4:     65, 8:     64, 16:     24, 32:
   4, 64:      8, 128:      7
client: 8046 total:  19495, 0:  19216, 1:     79, 2:     57, 4:     68, 8:     43, 16:      9, 32:
   5, 64:      5, 128:     13
client: 8047 total:  21898, 0:  21494, 1:     98, 2:     73, 4:    104, 8:     78, 16:     41, 32:
  10, 64:      0, 128:      0
client: 8048 total:  22382, 0:  22015, 1:    111, 2:     78, 4:     65, 8:     65, 16:     36, 32:
   9, 64:      2, 128:      1
client: 8049 total:  20273, 0:  20017, 1:     77, 2:     52, 4:     44, 8:     48, 16:     18, 32:
   3, 64:      4, 128:     10
client: 8050 total:  15142, 0:  14889, 1:     58, 2:     56, 4:     73, 8:     32, 16:      8, 32:
   2, 64:      5, 128:     19
client: 8051 total:  18219, 0:  17945, 1:     77, 2:     63, 4:     69, 8:     22, 16:     15, 32:
  12, 64:      4, 128:     12
client: 8052 total:    294, 0:    204, 1:      1, 2:      3, 4:     10, 8:     20, 16:      4, 32:
   2, 64:      2, 128:     48
client: 8053 total:  20336, 0:  20071, 1:     64, 2:     57, 4:     54, 8:     49, 16:     23, 32:
   6, 64:      4, 128:      8
client: 8054 total:    322, 0:    184, 1:      8, 2:      9, 4:     25, 8:     20, 16:     17, 32:
   8, 64:     11, 128:     40
client: 8055 total:  22594, 0:  22240, 1:    107, 2:     63, 4:     81, 8:     62, 16:     29, 32:
   7, 64:      2, 128:      3
client: 8056 total:  20490, 0:  20216, 1:     71, 2:     62, 4:     61, 8:     58, 16:      8, 32:
   1, 64:      2, 128:     11
client: 8057 total:  20998, 0:  20691, 1:     79, 2:     56, 4:     72, 8:     60, 16:     24, 32:
   8, 64:      5, 128:      3
client: 8058 total:  14891, 0:  14659, 1:     85, 2:     46, 4:     39, 8:     18, 16:     14, 32:
   5, 64:      7, 128:     18
client: 8059 total:    115, 0:     48, 1:      2, 2:      3, 4:      3, 8:      3, 16:      0, 32:
   4, 64:      9, 128:     43
client: 8060 total:  18525, 0:  18238, 1:     85, 2:     59, 4:     68, 8:     44, 16:     11, 32:
   4, 64:      3, 128:     13
client: 8061 total:  21922, 0:  21573, 1:     95, 2:     62, 4:     74, 8:     65, 16:     43, 32:
   8, 64:      2, 128:      0
client: 8062 total:  14312, 0:  14071, 1:     63, 2:     59, 4:     50, 8:     31, 16:      8, 32:
   5, 64:      4, 128:     21
client: 8063 total:  22949, 0:  22580, 1:     79, 2:     69, 4:     94, 8:     77, 16:     43, 32:
   6, 64:      1, 128:      0
client: 8064 total:  16250, 0:  15956, 1:     75, 2:     73, 4:     62, 8:     44, 16:     18, 32:
   5, 64:      5, 128:     12
client: 8065 total:  21563, 0:  21264, 1:     77, 2:     65, 4:     59, 8:     65, 16:     18, 32:
   8, 64:      2, 128:      5
client: 8066 total:  20547, 0:  20243, 1:    102, 2:     53, 4:     72, 8:     45, 16:     13, 32:
   4, 64:      3, 128:     12
client: 8067 total:  21177, 0:  20798, 1:     92, 2:     81, 4:     84, 8:     72, 16:     36, 32:
  10, 64:      4, 128:      0
client: 8068 total:  16058, 0:  15805, 1:     75, 2:     57, 4:     49, 8:     35, 16:     11, 32:
   6, 64:      3, 128:     17
client: 8069 total:  16352, 0:  16071, 1:     69, 2:     64, 4:     54, 8:     46, 16:     31, 32:
   2, 64:      2, 128:     13
client: 8070 total:  19025, 0:  18707, 1:     86, 2:     63, 4:     82, 8:     53, 16:     10, 32:
  12, 64:      1, 128:     11
client: 8071 total:  22167, 0:  21781, 1:     95, 2:     77, 4:     91, 8:     74, 16:     39, 32:
   8, 64:      2, 128:      0
client: 8072 total:  22721, 0:  22375, 1:     93, 2:     64, 4:     75, 8:     71, 16:     30, 32:
  10, 64:      3, 128:      0
client: 8073 total:  20201, 0:  19893, 1:     83, 2:     74, 4:     61, 8:     50, 16:     25, 32:
   5, 64:      3, 128:      7
client: 8074 total:  22851, 0:  22493, 1:     77, 2:     66, 4:     99, 8:     72, 16:     34, 32:
   6, 64:      3, 128:      1
client: 8075 total:  21957, 0:  21575, 1:     96, 2:     86, 4:     87, 8:     63, 16:     36, 32:
  12, 64:      2, 128:      0
client: 8076 total:   7148, 0:   6962, 1:     53, 2:     39, 4:     22, 8:     19, 16:     10, 32:
   6, 64:      7, 128:     30
client: 8077 total:  18487, 0:  18268, 1:     68, 2:     45, 4:     44, 8:     28, 16:     10, 32:
   5, 64:      7, 128:     12
client: 8078 total:  22233, 0:  21863, 1:    106, 2:     76, 4:     73, 8:     65, 16:     37, 32:
  10, 64:      1, 128:      2
client: 8079 total:    102, 0:     44, 1:      2, 2:      0, 4:      0, 8:      0, 16:      1, 32:
   0, 64:      3, 128:     52
client: 8080 total:  21897, 0:  21594, 1:     78, 2:     62, 4:     64, 8:     58, 16:     28, 32:
   6, 64:      4, 128:      3
client: 8081 total:  18551, 0:  18262, 1:     81, 2:     71, 4:     59, 8:     51, 16:      7, 32:
   5, 64:      1, 128:     14
client: 8082 total:  23025, 0:  22615, 1:     92, 2:     81, 4:    111, 8:     84, 16:     35, 32:
   5, 64:      2, 128:      0
client: 8083 total:  22263, 0:  21901, 1:     76, 2:     62, 4:    110, 8:     68, 16:     39, 32:
   3, 64:      1, 128:      3
client: 8084 total:  22927, 0:  22578, 1:     96, 2:     60, 4:     77, 8:     77, 16:     27, 32:
   9, 64:      2, 128:      1
client: 8085 total:  20433, 0:  20083, 1:    119, 2:     46, 4:     76, 8:     66, 16:     25, 32:
  13, 64:      2, 128:      3
client: 8086 total:  19569, 0:  19216, 1:    106, 2:     98, 4:     65, 8:     50, 16:     13, 32:
   6, 64:      4, 128:     11
client: 8087 total:  15973, 0:  15696, 1:     77, 2:     64, 4:     65, 8:     36, 16:      8, 32:
   6, 64:      4, 128:     17
client: 8088 total:  22661, 0:  22290, 1:     90, 2:     75, 4:     82, 8:     80, 16:     36, 32:
   6, 64:      2, 128:      0
client: 8089 total:  15271, 0:  15060, 1:     68, 2:     50, 4:     26, 8:     22, 16:     12, 32:
  19, 64:      3, 128:     11
client: 8090 total:  13826, 0:  13513, 1:     76, 2:     62, 4:     86, 8:     53, 16:     12, 32:
   5, 64:      1, 128:     18
client: 8091 total:  21208, 0:  20864, 1:     90, 2:     71, 4:     66, 8:     68, 16:     34, 32:
   9, 64:      3, 128:      3
client: 8092 total:  16926, 0:  16693, 1:     81, 2:     47, 4:     44, 8:     28, 16:      7, 32:
   3, 64:      5, 128:     18
client: 8093 total:    561, 0:    447, 1:      8, 2:     12, 4:      9, 8:     16, 16:      9, 32:
   9, 64:      4, 128:     47
client: 8094 total:    282, 0:    174, 1:      3, 2:      5, 4:     15, 8:     19, 16:      7, 32:
   8, 64:      5, 128:     46
client: 8095 total:  18351, 0:  17995, 1:     90, 2:     76, 4:     77, 8:     62, 16:     34, 32:
   7, 64:      2, 128:      8
client: 8096 total:  17184, 0:  16920, 1:     76, 2:     65, 4:     49, 8:     31, 16:     17, 32:
   8, 64:      7, 128:     11
client: 8097 total:  19907, 0:  19624, 1:     84, 2:     70, 4:     43, 8:     43, 16:     21, 32:
  10, 64:      4, 128:      8
client: 8098 total:  17149, 0:  16859, 1:     83, 2:     66, 4:     61, 8:     34, 16:     22, 32:
   6, 64:      8, 128:     10
client: 8099 total:  20320, 0:  19980, 1:     91, 2:     76, 4:     72, 8:     64, 16:     23, 32:
   5, 64:      2, 128:      7
client: 8100 total:  22179, 0:  21849, 1:     86, 2:     61, 4:     78, 8:     58, 16:     35, 32:
   7, 64:      1, 128:      4
client: 8101 total:  20722, 0:  20439, 1:     84, 2:     55, 4:     60, 8:     52, 16:     16, 32:
   6, 64:      2, 128:      8
client: 8102 total:    949, 0:    823, 1:     18, 2:     15, 4:      9, 8:     14, 16:     14, 32:
   5, 64:      6, 128:     45
client: 8103 total:  21761, 0:  21458, 1:     95, 2:     60, 4:     56, 8:     45, 16:     27, 32:
  11, 64:      4, 128:      5
client: 8104 total:  22120, 0:  21773, 1:     94, 2:     66, 4:     82, 8:     70, 16:     24, 32:
   7, 64:      1, 128:      3
client: 8105 total:  21818, 0:  21537, 1:     76, 2:     56, 4:     56, 8:     55, 16:     25, 32:
   5, 64:      2, 128:      6
client: 8106 total:  21216, 0:  20818, 1:     91, 2:     88, 4:     97, 8:     74, 16:     34, 32:
   9, 64:      3, 128:      2
client: 8107 total:    190, 0:    110, 1:      1, 2:      4, 4:      8, 8:      4, 16:      4, 32:
   5, 64:      2, 128:     52
client: 8108 total:  19847, 0:  19585, 1:     73, 2:     47, 4:     72, 8:     41, 16:     15, 32:
   1, 64:      0, 128:     13
client: 8109 total:  20635, 0:  20286, 1:    100, 2:     61, 4:     72, 8:     70, 16:     36, 32:
   4, 64:      3, 128:      3
client: 8110 total:  20301, 0:  19985, 1:     86, 2:     73, 4:     85, 8:     38, 16:     15, 32:
   6, 64:      2, 128:     11
client: 8111 total:    135, 0:     64, 1:      3, 2:      3, 4:      5, 8:      3, 16:      2, 32:
   4, 64:      5, 128:     46
client: 8112 total:  22689, 0:  22361, 1:     86, 2:     70, 4:     67, 8:     70, 16:     20, 32:
   9, 64:      4, 128:      2
client: 8113 total:  20953, 0:  20573, 1:     96, 2:     77, 4:     87, 8:     67, 16:     44, 32:
   5, 64:      4, 128:      0
client: 8114 total:  14639, 0:  14350, 1:     85, 2:     54, 4:     53, 8:     44, 16:     26, 32:
  10, 64:      5, 128:     12
client: 8115 total:  15707, 0:  15466, 1:     59, 2:     50, 4:     74, 8:     23, 16:      8, 32:
   5, 64:      4, 128:     18
client: 8116 total:    149, 0:     63, 1:      4, 2:      5, 4:      4, 8:      6, 16:      6, 32:
   7, 64:      9, 128:     45
client: 8117 total:  22157, 0:  21821, 1:     82, 2:     78, 4:     68, 8:     63, 16:     35, 32:
   4, 64:      4, 128:      2
client: 8118 total:  22345, 0:  22006, 1:     91, 2:     78, 4:     81, 8:     57, 16:     15, 32:
   8, 64:      0, 128:      9
client: 8119 total:  21778, 0:  21448, 1:     81, 2:     70, 4:     95, 8:     49, 16:     19, 32:
  10, 64:      1, 128:      5
client: 8120 total:    113, 0:     46, 1:      3, 2:      3, 4:      2, 8:      2, 16:      0, 32:
   3, 64:      2, 128:     52
client: 8121 total:   7309, 0:   7117, 1:     45, 2:     44, 4:     37, 8:     15, 16:      9, 32:
   6, 64:      3, 128:     33
client: 8122 total:  22374, 0:  21956, 1:    122, 2:     92, 4:    100, 8:     65, 16:     30, 32:
   3, 64:      1, 128:      5
client: 8123 total:  14384, 0:  14189, 1:     53, 2:     39, 4:     36, 8:     24, 16:      7, 32:
   8, 64:      9, 128:     19
client: 8124 total:  23063, 0:  22683, 1:    108, 2:     74, 4:     77, 8:     75, 16:     36, 32:
   9, 64:      1, 128:      0
client: 8125 total:  20695, 0:  20392, 1:     88, 2:     70, 4:     70, 8:     39, 16:     21, 32:
   3, 64:      3, 128:      9
client: 8126 total:  21012, 0:  20679, 1:     85, 2:     66, 4:     81, 8:     49, 16:     38, 32:
   5, 64:      5, 128:      4
client: 8127 total:  20025, 0:  19793, 1:     81, 2:     51, 4:     45, 8:     26, 16:      7, 32:
   5, 64:      1, 128:     16

Iter
--------
client: 8000 total:  14121, 0:  13779, 1:    112, 2:     75, 4:     56, 8:     35, 16:     34, 32:
   8, 64:      3, 128:     19
client: 8001 total:    971, 0:    841, 1:     18, 2:     18, 4:      6, 8:     17, 16:     16, 32:
   6, 64:      3, 128:     46
client: 8002 total:  12839, 0:  12421, 1:    133, 2:    105, 4:     60, 8:     66, 16:     24, 32:
   8, 64:      2, 128:     20
client: 8003 total:    368, 0:    257, 1:     11, 2:      6, 4:      4, 8:     12, 16:     23, 32:
   8, 64:      2, 128:     45
client: 8004 total:  16448, 0:  16039, 1:    145, 2:     89, 4:     64, 8:     39, 16:     46, 32:
  13, 64:      2, 128:     11
client: 8005 total:  11609, 0:  11174, 1:    161, 2:     99, 4:     51, 8:     53, 16:     36, 32:
  14, 64:      7, 128:     14
client: 8006 total:    545, 0:    409, 1:     14, 2:     10, 4:     21, 8:     21, 16:     18, 32:
   5, 64:      2, 128:     45
client: 8007 total:    494, 0:    381, 1:     11, 2:      9, 4:      8, 8:     13, 16:     18, 32:
   3, 64:      2, 128:     49
client: 8008 total:  13670, 0:  13372, 1:    102, 2:     58, 4:     39, 8:     39, 16:     27, 32:
   8, 64:      2, 128:     23
client: 8009 total:   8090, 0:   7850, 1:     69, 2:     36, 4:     36, 8:     24, 16:     32, 32:
  10, 64:     10, 128:     23
client: 8010 total:  14054, 0:  13685, 1:    138, 2:     74, 4:     46, 8:     49, 16:     33, 32:
  11, 64:      5, 128:     13
client: 8011 total:    143, 0:     78, 1:      5, 2:      4, 4:      2, 8:      3, 16:      5, 32:
   2, 64:      3, 128:     41
client: 8012 total:  20632, 0:  20197, 1:    155, 2:     94, 4:     69, 8:     58, 16:     36, 32:
  10, 64:      6, 128:      7
client: 8013 total:  10267, 0:   9835, 1:    158, 2:     86, 4:     57, 8:     53, 16:     43, 32:
  16, 64:      7, 128:     12
client: 8014 total:  16010, 0:  15508, 1:    159, 2:    114, 4:     83, 8:     72, 16:     46, 32:
  12, 64:      8, 128:      8
client: 8015 total:   6397, 0:   6084, 1:    101, 2:     65, 4:     43, 8:     31, 16:     25, 32:
  12, 64:     11, 128:     25
client: 8016 total:  18809, 0:  18390, 1:    164, 2:     88, 4:     58, 8:     54, 16:     29, 32:
  11, 64:      5, 128:     10
client: 8017 total:    590, 0:    453, 1:     14, 2:     18, 4:     12, 8:     17, 16:     23, 32:
   7, 64:      5, 128:     41
client: 8018 total:  12294, 0:  11840, 1:    164, 2:     80, 4:     80, 8:     68, 16:     35, 32:
   7, 64:      3, 128:     17
client: 8019 total:  18262, 0:  17816, 1:    156, 2:     86, 4:     60, 8:     63, 16:     54, 32:
  14, 64:      5, 128:      8
client: 8020 total:    272, 0:    175, 1:      7, 2:      6, 4:      7, 8:     13, 16:     12, 32:
   1, 64:      1, 128:     50
client: 8021 total:  11309, 0:  10922, 1:    156, 2:     71, 4:     44, 8:     46, 16:     36, 32:
  11, 64:      5, 128:     18
client: 8022 total:   9943, 0:   9569, 1:    121, 2:     78, 4:     52, 8:     56, 16:     35, 32:
   5, 64:      4, 128:     23
client: 8023 total:  12604, 0:  12325, 1:     89, 2:     49, 4:     29, 8:     40, 16:     37, 32:
   6, 64:      4, 128:     25
client: 8024 total:    239, 0:    143, 1:     11, 2:      5, 4:      4, 8:     11, 16:      5, 32:
   8, 64:      2, 128:     50
client: 8025 total:  13421, 0:  13017, 1:    139, 2:     76, 4:     54, 8:     63, 16:     40, 32:
  16, 64:      3, 128:     13
client: 8026 total:  15772, 0:  15345, 1:    120, 2:     92, 4:     74, 8:     70, 16:     48, 32:
   6, 64:      3, 128:     14
client: 8027 total:  11230, 0:  10848, 1:    134, 2:     71, 4:     59, 8:     45, 16:     35, 32:
  12, 64:      6, 128:     20
client: 8028 total:   1830, 0:   1721, 1:     17, 2:     16, 4:      6, 8:      8, 16:     12, 32:
   3, 64:      6, 128:     41
client: 8029 total:  10083, 0:   9774, 1:     92, 2:     69, 4:     32, 8:     46, 16:     35, 32:
   8, 64:      4, 128:     23
client: 8030 total:   1012, 0:    849, 1:     36, 2:     21, 4:     24, 8:     13, 16:     13, 32:
   9, 64:      4, 128:     43
client: 8031 total:   4612, 0:   4416, 1:     51, 2:     29, 4:     21, 8:     26, 16:     20, 32:
   8, 64:      1, 128:     40
client: 8032 total:  11946, 0:  11722, 1:     66, 2:     37, 4:     33, 8:     30, 16:     23, 32:
   7, 64:      2, 128:     26
client: 8033 total:  10378, 0:   9927, 1:    140, 2:     96, 4:     65, 8:     68, 16:     53, 32:
  14, 64:      4, 128:     11
client: 8034 total:  16426, 0:  15992, 1:    146, 2:    104, 4:     54, 8:     61, 16:     42, 32:
   7, 64:      5, 128:     15
client: 8035 total:    363, 0:    254, 1:      6, 2:     10, 4:      6, 8:     13, 16:     16, 32:
   8, 64:      2, 128:     48
client: 8036 total:  13494, 0:  13154, 1:    110, 2:     78, 4:     46, 8:     38, 16:     36, 32:
  12, 64:      3, 128:     17
client: 8037 total:   3484, 0:   3107, 1:    124, 2:     53, 4:     54, 8:     45, 16:     59, 32:
  13, 64:      7, 128:     22
client: 8038 total:  12188, 0:  11771, 1:    146, 2:    100, 4:     63, 8:     43, 16:     30, 32:
   8, 64:      9, 128:     18
client: 8039 total:    111, 0:     51, 1:      1, 2:      5, 4:      2, 8:      1, 16:      4, 32:
   3, 64:      6, 128:     38
client: 8040 total:  20964, 0:  20540, 1:    164, 2:     81, 4:     58, 8:     59, 16:     45, 32:
   7, 64:      2, 128:      8
client: 8041 total:   9241, 0:   8902, 1:    119, 2:     57, 4:     38, 8:     46, 16:     42, 32:
  12, 64:      6, 128:     19
client: 8042 total:  14728, 0:  14243, 1:    178, 2:    101, 4:     75, 8:     71, 16:     33, 32:
  11, 64:      2, 128:     14
client: 8043 total:  14801, 0:  14391, 1:    156, 2:     77, 4:     62, 8:     52, 16:     30, 32:
  10, 64:      8, 128:     15
client: 8044 total:  15839, 0:  15523, 1:    107, 2:     76, 4:     43, 8:     36, 16:     22, 32:
  10, 64:      6, 128:     16
client: 8045 total:  11071, 0:  10653, 1:    155, 2:     87, 4:     55, 8:     44, 16:     38, 32:
  18, 64:      6, 128:     15
client: 8046 total:  12679, 0:  12309, 1:    125, 2:     81, 4:     37, 8:     62, 16:     33, 32:
   8, 64:      6, 128:     18
client: 8047 total:  16110, 0:  15739, 1:    141, 2:     77, 4:     48, 8:     37, 16:     35, 32:
  12, 64:      4, 128:     17
client: 8048 total:    340, 0:    235, 1:     13, 2:      9, 4:      6, 8:      9, 16:     12, 32:
   4, 64:      4, 128:     48
client: 8049 total:  10688, 0:  10327, 1:    124, 2:     71, 4:     54, 8:     42, 16:     37, 32:
   8, 64:      4, 128:     21
client: 8050 total:  11683, 0:  11335, 1:    111, 2:     76, 4:     40, 8:     56, 16:     30, 32:
   8, 64:      5, 128:     22
client: 8051 total:  11739, 0:  11324, 1:    136, 2:     80, 4:     68, 8:     52, 16:     37, 32:
  22, 64:      8, 128:     12
client: 8052 total:    279, 0:    188, 1:     11, 2:      5, 4:      5, 8:      6, 16:      7, 32:
   4, 64:      2, 128:     51
client: 8053 total:   4092, 0:   3762, 1:     90, 2:     57, 4:     47, 8:     47, 16:     46, 32:
  12, 64:      4, 128:     27
client: 8054 total:   7608, 0:   7340, 1:     87, 2:     62, 4:     28, 8:     33, 16:     18, 32:
   1, 64:      2, 128:     37
client: 8055 total:  15961, 0:  15477, 1:    178, 2:    105, 4:     67, 8:     60, 16:     45, 32:
  12, 64:      6, 128:     11
client: 8056 total:  16455, 0:  16136, 1:    104, 2:     60, 4:     51, 8:     54, 16:     27, 32:
   9, 64:      4, 128:     10
client: 8057 total:    852, 0:    710, 1:     24, 2:     12, 4:     12, 8:     18, 16:     22, 32:
   7, 64:      5, 128:     42
client: 8058 total:  13652, 0:  13131, 1:    174, 2:    115, 4:     76, 8:     77, 16:     48, 32:
  17, 64:      4, 128:     10
client: 8059 total:  15992, 0:  15589, 1:    162, 2:     81, 4:     52, 8:     47, 16:     26, 32:
  13, 64:      6, 128:     16
client: 8060 total:  15021, 0:  14701, 1:    108, 2:     70, 4:     49, 8:     34, 16:     30, 32:
  11, 64:      4, 128:     14
client: 8061 total:  12373, 0:  11910, 1:    157, 2:    102, 4:     66, 8:     64, 16:     41, 32:
  15, 64:      8, 128:     10
client: 8062 total:  14021, 0:  13540, 1:    155, 2:    113, 4:     72, 8:     78, 16:     36, 32:
   6, 64:      6, 128:     15
client: 8063 total:  14293, 0:  13896, 1:    164, 2:     81, 4:     45, 8:     43, 16:     31, 32:
  11, 64:      2, 128:     20
client: 8064 total:  12779, 0:  12380, 1:    155, 2:     78, 4:     55, 8:     36, 16:     41, 32:
  15, 64:      1, 128:     18
client: 8065 total:   9565, 0:   9238, 1:    108, 2:     65, 4:     47, 8:     39, 16:     29, 32:
  13, 64:      3, 128:     23
client: 8066 total:  15698, 0:  15314, 1:    150, 2:     71, 4:     51, 8:     55, 16:     34, 32:
   3, 64:      8, 128:     12
client: 8067 total:   5310, 0:   5066, 1:     68, 2:     29, 4:     32, 8:     39, 16:     30, 32:
  11, 64:      4, 128:     31
client: 8068 total:  19220, 0:  18902, 1:    116, 2:     62, 4:     41, 8:     39, 16:     32, 32:
   9, 64:      4, 128:     15
client: 8069 total:  13087, 0:  12684, 1:    135, 2:     77, 4:     51, 8:     72, 16:     41, 32:
  13, 64:      8, 128:      6
client: 8070 total:    236, 0:    144, 1:      6, 2:      7, 4:      8, 8:      9, 16:      9, 32:
   7, 64:      2, 128:     44
client: 8071 total:    125, 0:     60, 1:      7, 2:      6, 4:      0, 8:      4, 16:      1, 32:
   0, 64:      1, 128:     46
client: 8072 total:  11738, 0:  11382, 1:    108, 2:     74, 4:     58, 8:     51, 16:     29, 32:
  11, 64:     10, 128:     15
client: 8073 total:  10799, 0:  10306, 1:    208, 2:     85, 4:     64, 8:     64, 16:     42, 32:
  12, 64:      5, 128:     13
client: 8074 total:  18754, 0:  18275, 1:    165, 2:    105, 4:     87, 8:     60, 16:     39, 32:
   7, 64:      4, 128:     12
client: 8075 total:  18639, 0:  18113, 1:    191, 2:    116, 4:     72, 8:     68, 16:     50, 32:
  21, 64:      3, 128:      5
client: 8076 total:    251, 0:    161, 1:      9, 2:      7, 4:      6, 8:      8, 16:      3, 32:
   4, 64:      0, 128:     53
client: 8077 total:  13366, 0:  12914, 1:    158, 2:    108, 4:     53, 8:     67, 16:     41, 32:
   6, 64:      5, 128:     14
client: 8078 total:   1191, 0:   1052, 1:     36, 2:     10, 4:     20, 8:     11, 16:      8, 32:
   5, 64:      1, 128:     48
client: 8079 total:  14350, 0:  13942, 1:    159, 2:     83, 4:     47, 8:     46, 16:     39, 32:
  12, 64:      5, 128:     17
client: 8080 total:    253, 0:    170, 1:      1, 2:      4, 4:      8, 8:      7, 16:      6, 32:
   5, 64:      2, 128:     50
client: 8081 total:    321, 0:    220, 1:     12, 2:      6, 4:      9, 8:      8, 16:     14, 32:
  11, 64:      4, 128:     37
client: 8082 total:    237, 0:    147, 1:     10, 2:      5, 4:      8, 8:      5, 16:      7, 32:
   2, 64:      2, 128:     51
client: 8083 total:  13568, 0:  13115, 1:    158, 2:    109, 4:     56, 8:     49, 16:     47, 32:
  15, 64:      9, 128:     10
client: 8084 total:  18991, 0:  18621, 1:    139, 2:     82, 4:     52, 8:     43, 16:     30, 32:
   5, 64:      7, 128:     12
client: 8085 total:  10920, 0:  10418, 1:    172, 2:    105, 4:     77, 8:     65, 16:     55, 32:
  16, 64:      7, 128:      5
client: 8086 total:  13146, 0:  12774, 1:    132, 2:     84, 4:     48, 8:     55, 16:     21, 32:
   5, 64:      3, 128:     24
client: 8087 total:  13051, 0:  12642, 1:    150, 2:     82, 4:     64, 8:     48, 16:     35, 32:
   6, 64:      6, 128:     18
client: 8088 total:    265, 0:    159, 1:     24, 2:      5, 4:      5, 8:      9, 16:      6, 32:
   4, 64:      4, 128:     49
client: 8089 total:  10050, 0:   9722, 1:    112, 2:     65, 4:     46, 8:     39, 16:     34, 32:
   8, 64:      2, 128:     22
client: 8090 total:   4655, 0:   4375, 1:     84, 2:     45, 4:     41, 8:     41, 16:     24, 32:
   7, 64:      3, 128:     35
client: 8091 total:   8000, 0:   7731, 1:     75, 2:     62, 4:     37, 8:     39, 16:     14, 32:
   6, 64:      3, 128:     33
client: 8092 total:  16401, 0:  16101, 1:     97, 2:     68, 4:     46, 8:     27, 16:     33, 32:
   7, 64:      6, 128:     16
client: 8093 total:   9085, 0:   8819, 1:     89, 2:     57, 4:     35, 8:     28, 16:     18, 32:
   5, 64:      6, 128:     28
client: 8094 total:   3282, 0:   3096, 1:     39, 2:     25, 4:     17, 8:     38, 16:     16, 32:
   9, 64:      2, 128:     40
client: 8095 total:   4801, 0:   4593, 1:     66, 2:     31, 4:     19, 8:     29, 16:     14, 32:
   7, 64:      6, 128:     36
client: 8096 total:    250, 0:    151, 1:     13, 2:      9, 4:      8, 8:      5, 16:      6, 32:
   6, 64:      2, 128:     50
client: 8097 total:  11283, 0:  10968, 1:    118, 2:     70, 4:     40, 8:     35, 16:     18, 32:
  10, 64:      5, 128:     19
client: 8098 total:    360, 0:    262, 1:     11, 2:     10, 4:     11, 8:      4, 16:      8, 32:
   4, 64:      2, 128:     48
client: 8099 total:    757, 0:    610, 1:     14, 2:     15, 4:     19, 8:     20, 16:     22, 32:
  11, 64:      5, 128:     41
client: 8100 total:  19463, 0:  19068, 1:    136, 2:     85, 4:     66, 8:     58, 16:     30, 32:
   4, 64:      3, 128:     13
client: 8101 total:    583, 0:    465, 1:     19, 2:     14, 4:      7, 8:     10, 16:     16, 32:
   1, 64:      4, 128:     47
client: 8102 total:    338, 0:    225, 1:     14, 2:     12, 4:     11, 8:     16, 16:      4, 32:
   4, 64:      4, 128:     48
client: 8103 total:  19114, 0:  18629, 1:    185, 2:    109, 4:     61, 8:     56, 16:     41, 32:
  19, 64:      8, 128:      6
client: 8104 total:  14240, 0:  13989, 1:     94, 2:     57, 4:     27, 8:     23, 16:     16, 32:
   4, 64:      5, 128:     25
client: 8105 total:  11671, 0:  11196, 1:    155, 2:    107, 4:     63, 8:     62, 16:     59, 32:
  15, 64:      4, 128:     10
client: 8106 total:  16529, 0:  16094, 1:    126, 2:     94, 4:     77, 8:     66, 16:     43, 32:
  12, 64:      5, 128:     12
client: 8107 total:  17224, 0:  16860, 1:    136, 2:     80, 4:     44, 8:     38, 16:     36, 32:
   7, 64:      4, 128:     19
client: 8108 total:  19373, 0:  18955, 1:    173, 2:     77, 4:     56, 8:     42, 16:     47, 32:
  12, 64:      3, 128:      8
client: 8109 total:    156, 0:     88, 1:      7, 2:      4, 4:      2, 8:      0, 16:      2, 32:
   5, 64:      5, 128:     43
client: 8110 total:   6666, 0:   6351, 1:    117, 2:     67, 4:     31, 8:     41, 16:     17, 32:
   4, 64:      3, 128:     35
client: 8111 total:  16982, 0:  16548, 1:    153, 2:     96, 4:     66, 8:     56, 16:     37, 32:
   7, 64:      7, 128:     12
client: 8112 total:    304, 0:    200, 1:      8, 2:      7, 4:      8, 8:     11, 16:     17, 32:
   3, 64:      4, 128:     46
client: 8113 total:   9754, 0:   9347, 1:    119, 2:    101, 4:     48, 8:     61, 16:     46, 32:
  11, 64:      7, 128:     14
client: 8114 total:  18182, 0:  17683, 1:    177, 2:    112, 4:     68, 8:     76, 16:     40, 32:
  13, 64:      5, 128:      8
client: 8115 total:  15770, 0:  15451, 1:    117, 2:     66, 4:     44, 8:     35, 16:     25, 32:
   8, 64:      2, 128:     22
client: 8116 total:  20568, 0:  20183, 1:    142, 2:     85, 4:     64, 8:     38, 16:     26, 32:
  13, 64:      6, 128:     11
client: 8117 total:  13111, 0:  12633, 1:    180, 2:    105, 4:     61, 8:     60, 16:     42, 32:
  12, 64:      5, 128:     13
client: 8118 total:   5527, 0:   5278, 1:     84, 2:     35, 4:     30, 8:     41, 16:     15, 32:
   4, 64:      2, 128:     38
client: 8119 total:    401, 0:    293, 1:     11, 2:     13, 4:      9, 8:      5, 16:     12, 32:
   6, 64:      5, 128:     47
client: 8120 total:  14131, 0:  13778, 1:    128, 2:     75, 4:     47, 8:     42, 16:     27, 32:
  13, 64:      4, 128:     17
client: 8121 total:  13590, 0:  13147, 1:    144, 2:     98, 4:     67, 8:     67, 16:     42, 32:
   7, 64:      3, 128:     15
client: 8122 total:  15467, 0:  15031, 1:    164, 2:     94, 4:     72, 8:     41, 16:     37, 32:
   5, 64:      4, 128:     19
client: 8123 total:    327, 0:    208, 1:     13, 2:      9, 4:     13, 8:      8, 16:     18, 32:
  11, 64:      1, 128:     46
client: 8124 total:  17100, 0:  16794, 1:    109, 2:     72, 4:     40, 8:     37, 16:     22, 32:
  10, 64:      5, 128:     11
client: 8125 total:   8567, 0:   8299, 1:     91, 2:     46, 4:     28, 8:     33, 16:     31, 32:
   9, 64:      4, 128:     26
client: 8126 total:  18846, 0:  18329, 1:    177, 2:    110, 4:     83, 8:     79, 16:     49, 32:
   9, 64:      2, 128:      8
client: 8127 total:  10824, 0:  10478, 1:    124, 2:     66, 4:     45, 8:     39, 16:     30, 32:
  13, 64:      8, 128:     21

-- 
Best regards,
Ridong


