Return-Path: <cgroups+bounces-13339-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NdnB92LcGkEYQAAu9opvQ
	(envelope-from <cgroups+bounces-13339-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 09:18:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A10A53616
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 09:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D88DC50254C
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 08:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C034472787;
	Wed, 21 Jan 2026 08:13:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F18313268;
	Wed, 21 Jan 2026 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983193; cv=none; b=kjR70IFpEJFLvjnySjK/VTW5JhIK60Xz+zdY4dSIWUVmmSAxV5AFUHEbWv6M0MLt06t7zlIiIbqSxKL5IU2aZt2a7D5JaEGAgX7LdkAAj+5CxfV9cDgeeNadfn5mdhMGShcHanCutghxcEOhndstYXsnI6B49finDQo8vrCpS98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983193; c=relaxed/simple;
	bh=YNRK0q3WfOOaI3Wm+irdw7fXpf1P2DUh2dyGP5XDseI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqU1sC7wUwNDMVM9UCoDZRg6CSH5U2L7D1uZja1+yhEORFY3Wak5YIUobzB89RZHUu6Ze8iewmjtcpFj6apyVjKBbadqqqpBFr8t+OZVOPM7TVTdZmc9IVhHceu2JQnDTMVBTdLOXI512L6phPXdrMpGVSQiuq/y8mOHzGgsTbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dwxlK4sm9zKHqFt;
	Wed, 21 Jan 2026 16:13:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 21C094058F;
	Wed, 21 Jan 2026 16:13:03 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCnCPmNinBpxGZMEg--.2389S2;
	Wed, 21 Jan 2026 16:13:02 +0800 (CST)
Message-ID: <81fdb4ce-a212-4b9c-83aa-8d127d75df8e@huaweicloud.com>
Date: Wed, 21 Jan 2026 16:13:00 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 5/7] mm/mglru: combine shrink_many into
 shrink_node_memcgs
To: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, zhengqi.arch@bytedance.com
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, lujialin4@huawei.com,
 ryncsn@gmail.com
References: <20260120134256.2271710-1-chenridong@huaweicloud.com>
 <20260120134256.2271710-6-chenridong@huaweicloud.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260120134256.2271710-6-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCnCPmNinBpxGZMEg--.2389S2
X-Coremail-Antispam: 1UD129KBjvAXoWfCF1DArW5uF1Utr1fCr1DAwb_yoW5tFy8to
	W3t3W29F4DW3s8Ar1kJa13WF4rWFy8Zr4kAw4vqrW8Ka9IkrWFywn3W3WUGw45ZryIya9r
	Zws8Z3WrJw4xGF97n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
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
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,huawei.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-13339-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,client.py:url,huaweicloud.com:mid,js_benchmark.sh:url,common.by:url,localhost:email]
X-Rspamd-Queue-Id: 6A10A53616
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/1/20 21:42, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The memcg LRU was originally introduced to improve scalability during
> global reclaim, but it only supports gen lru global reclaim and remains
> complex in implementation.
> 
> Previous patches have introduced heat-level-based memcg reclaim, which is
> significantly simpler. This patch switches gen lru global reclaim to the
> heat-level-based reclaim mechanism.
> 
> The following results are from a 24-hour test provided by YU Zhao [1]:
> 
> Throughput (number of requests)         before     after        Change
> Total                                   22879701    25331956      +10%
> 
> Tail latency (number of requests)       before     after        Change
> [128s, inf)                             19197	    15628	-19%
> [64s, 128s)                             4500	    3815	-29%
> [32s, 64s)                              14971	    13755	-36%
> [16s, 32s)                              46117	    42942	-7%
> 

The original data:

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

sleep $((24 * 60 * 60))
trap 'wait' SIGINT
kill -INT 0
```
Results(run 24h)
=======
Before
------
client: 8000 total: 203354, 0: 195960, 1:   3194, 2:   1622, 4:   1007, 8:    825, 16:    521, 32:    138, 64:     28, 128:     59
client: 8001 total: 221354, 0: 215938, 1:   2094, 2:   1177, 4:    813, 8:    683, 16:    404, 32:    125, 64:     36, 128:     84
client: 8002 total: 197570, 0: 191087, 1:   2674, 2:   1455, 4:    962, 8:    731, 16:    401, 32:    116, 64:     46, 128:     98
client: 8003 total: 198080, 0: 190687, 1:   3002, 2:   1666, 4:   1224, 8:    868, 16:    377, 32:    141, 64:     26, 128:     89
client: 8004 total: 226324, 0: 220995, 1:   1982, 2:   1147, 4:    902, 8:    662, 16:    367, 32:    130, 64:     34, 128:    105
client: 8005 total: 189168, 0: 182905, 1:   2648, 2:   1428, 4:    865, 8:    662, 16:    384, 32:    142, 64:     44, 128:     90
client: 8006 total: 197030, 0: 190547, 1:   2640, 2:   1449, 4:    972, 8:    744, 16:    429, 32:    116, 64:     32, 128:    101
client: 8007 total: 160381, 0: 152282, 1:   3590, 2:   1862, 4:   1159, 8:    816, 16:    392, 32:    124, 64:     37, 128:    119
client: 8008 total:    730, 0:     46, 1:      1, 2:      0, 4:      0, 8:      1, 16:      2, 32:      2, 64:      3, 128:    675
client: 8009 total: 198599, 0: 194010, 1:   1618, 2:    949, 4:    738, 8:    611, 16:    355, 32:    119, 64:     45, 128:    154
client: 8010 total: 186917, 0: 180492, 1:   2603, 2:   1466, 4:    942, 8:    758, 16:    386, 32:    112, 64:     32, 128:    126
client: 8011 total: 192189, 0: 185203, 1:   2807, 2:   1527, 4:   1181, 8:    855, 16:    359, 32:    105, 64:     24, 128:    128
client: 8012 total: 238234, 0: 231221, 1:   2869, 2:   1541, 4:   1027, 8:    851, 16:    524, 32:    143, 64:     37, 128:     21
client: 8013 total: 205769, 0: 199608, 1:   2743, 2:   1335, 4:    803, 8:    635, 16:    391, 32:    132, 64:     34, 128:     88
client: 8014 total: 217792, 0: 212037, 1:   2201, 2:   1289, 4:    914, 8:    742, 16:    349, 32:    123, 64:     33, 128:    104
client: 8015 total: 158164, 0: 150414, 1:   3426, 2:   1805, 4:   1046, 8:    788, 16:    395, 32:    134, 64:     39, 128:    117
client: 8016 total: 200305, 0: 194212, 1:   2667, 2:   1287, 4:    859, 8:    631, 16:    373, 32:    113, 64:     50, 128:    113
client: 8017 total: 199062, 0: 192285, 1:   2984, 2:   1473, 4:    943, 8:    699, 16:    441, 32:    108, 64:     45, 128:     84
client: 8018 total: 207037, 0: 201816, 1:   1972, 2:   1183, 4:    816, 8:    625, 16:    323, 32:    123, 64:     41, 128:    138
client: 8019 total: 187363, 0: 180069, 1:   3070, 2:   1685, 4:   1092, 8:    815, 16:    358, 32:    134, 64:     37, 128:    103
client: 8020 total: 190469, 0: 183580, 1:   3200, 2:   1535, 4:    880, 8:    623, 16:    356, 32:    156, 64:     39, 128:    100
client: 8021 total: 186108, 0: 179330, 1:   3004, 2:   1521, 4:    868, 8:    682, 16:    421, 32:    154, 64:     33, 128:     95
client: 8022 total: 204060, 0: 197872, 1:   2412, 2:   1368, 4:   1006, 8:    755, 16:    382, 32:    125, 64:     45, 128:     95
client: 8023 total: 182051, 0: 174786, 1:   3025, 2:   1645, 4:   1132, 8:    823, 16:    360, 32:    140, 64:     30, 128:    110
client: 8024 total: 194985, 0: 188045, 1:   3105, 2:   1551, 4:    944, 8:    665, 16:    423, 32:    117, 64:     24, 128:    111
client: 8025 total: 178930, 0: 172231, 1:   2789, 2:   1528, 4:    921, 8:    726, 16:    448, 32:    148, 64:     46, 128:     93
client: 8026 total: 200200, 0: 193698, 1:   2559, 2:   1497, 4:   1005, 8:    766, 16:    420, 32:    121, 64:     36, 128:     98
client: 8027 total:   1210, 0:    465, 1:     13, 2:      5, 4:      8, 8:     16, 16:     16, 32:      7, 64:      6, 128:    674
client: 8028 total: 184813, 0: 178238, 1:   2827, 2:   1422, 4:    899, 8:    677, 16:    453, 32:    147, 64:     43, 128:    107
client: 8029 total: 214989, 0: 209477, 1:   2174, 2:   1228, 4:    856, 8:    611, 16:    363, 32:    150, 64:     38, 128:     92
client: 8030 total: 197567, 0: 191157, 1:   2618, 2:   1472, 4:    965, 8:    671, 16:    399, 32:    144, 64:     49, 128:     92
client: 8031 total: 205532, 0: 197038, 1:   3687, 2:   2046, 4:   1271, 8:    930, 16:    350, 32:     79, 64:     30, 128:    101
client: 8032 total: 206078, 0: 200350, 1:   2365, 2:   1251, 4:    863, 8:    629, 16:    348, 32:    111, 64:     34, 128:    127
client: 8033 total: 213999, 0: 208093, 1:   2373, 2:   1287, 4:    848, 8:    700, 16:    427, 32:    153, 64:     39, 128:     79
client: 8034 total: 212129, 0: 205917, 1:   2581, 2:   1336, 4:    946, 8:    721, 16:    390, 32:    101, 64:     25, 128:    112
client: 8035 total: 162439, 0: 154590, 1:   3521, 2:   1781, 4:   1082, 8:    789, 16:    378, 32:    147, 64:     47, 128:    104
client: 8036 total: 203706, 0: 197140, 1:   2754, 2:   1465, 4:    972, 8:    682, 16:    437, 32:    131, 64:     32, 128:     93
client: 8037 total: 215559, 0: 209578, 1:   2547, 2:   1257, 4:    871, 8:    660, 16:    376, 32:    145, 64:     47, 128:     78
client: 8038 total: 205566, 0: 198917, 1:   2667, 2:   1484, 4:    976, 8:    818, 16:    465, 32:    117, 64:     37, 128:     85
client: 8039 total: 189199, 0: 181020, 1:   3677, 2:   1989, 4:   1169, 8:    764, 16:    335, 32:     95, 64:     38, 128:    112
client: 8040 total: 176658, 0: 168852, 1:   3566, 2:   1722, 4:    997, 8:    778, 16:    487, 32:    144, 64:     35, 128:     77
client: 8041 total: 205764, 0: 199420, 1:   2707, 2:   1409, 4:    874, 8:    679, 16:    407, 32:    149, 64:     35, 128:     84
client: 8042 total: 207689, 0: 201830, 1:   2350, 2:   1303, 4:    922, 8:    653, 16:    365, 32:    112, 64:     34, 128:    120
client: 8043 total: 175372, 0: 167791, 1:   3376, 2:   1679, 4:   1101, 8:    821, 16:    337, 32:    117, 64:     42, 128:    108
client: 8044 total: 177436, 0: 169996, 1:   3245, 2:   1689, 4:   1009, 8:    800, 16:    432, 32:    145, 64:     24, 128:     96
client: 8045 total:    742, 0:     49, 1:      2, 2:      1, 4:      2, 8:      1, 16:      1, 32:      5, 64:      4, 128:    677
client: 8046 total: 204207, 0: 197971, 1:   2489, 2:   1435, 4:    918, 8:    749, 16:    395, 32:    111, 64:     27, 128:    112
client: 8047 total: 170068, 0: 162797, 1:   3096, 2:   1662, 4:   1051, 8:    799, 16:    375, 32:    115, 64:     46, 128:    127
client: 8048 total: 192235, 0: 184906, 1:   3301, 2:   1638, 4:   1000, 8:    717, 16:    416, 32:    133, 64:     29, 128:     95
client: 8049 total: 217400, 0: 211590, 1:   2358, 2:   1288, 4:    818, 8:    708, 16:    392, 32:    125, 64:     37, 128:     84
client: 8050 total: 194428, 0: 188239, 1:   2462, 2:   1459, 4:    940, 8:    694, 16:    356, 32:    117, 64:     42, 128:    119
client: 8051 total: 161159, 0: 153218, 1:   3423, 2:   1824, 4:   1158, 8:    859, 16:    403, 32:    118, 64:     43, 128:    113
client: 8052 total: 194639, 0: 187743, 1:   2961, 2:   1507, 4:    922, 8:    771, 16:    467, 32:    152, 64:     42, 128:     74
client: 8053 total: 215419, 0: 208860, 1:   2651, 2:   1412, 4:   1005, 8:    767, 16:    476, 32:    160, 64:     31, 128:     57
client: 8054 total: 208002, 0: 201134, 1:   2905, 2:   1523, 4:    996, 8:    760, 16:    435, 32:    130, 64:     36, 128:     83
client: 8055 total: 192324, 0: 183365, 1:   4180, 2:   2119, 4:   1214, 8:    836, 16:    380, 32:    124, 64:     33, 128:     73
client: 8056 total: 176504, 0: 169140, 1:   3203, 2:   1674, 4:   1001, 8:    724, 16:    488, 32:    150, 64:     30, 128:     94
client: 8057 total: 196675, 0: 190174, 1:   2674, 2:   1455, 4:    966, 8:    743, 16:    397, 32:    132, 64:     30, 128:    104
client: 8058 total:    744, 0:     44, 1:      1, 2:      3, 4:      2, 8:      2, 16:      3, 32:      2, 64:      2, 128:    685
client: 8059 total: 166395, 0: 159333, 1:   2935, 2:   1540, 4:   1083, 8:    811, 16:    393, 32:    129, 64:     41, 128:    130
client: 8060 total: 213156, 0: 207022, 1:   2580, 2:   1324, 4:    945, 8:    656, 16:    385, 32:    101, 64:     37, 128:    106
client: 8061 total: 190561, 0: 184265, 1:   2727, 2:   1432, 4:    864, 8:    619, 16:    365, 32:    148, 64:     33, 128:    108
client: 8062 total: 203531, 0: 197486, 1:   2359, 2:   1347, 4:    910, 8:    745, 16:    413, 32:    130, 64:     34, 128:    107
client: 8063 total: 180376, 0: 172771, 1:   3286, 2:   1704, 4:   1112, 8:    811, 16:    420, 32:    139, 64:     47, 128:     86
client: 8064 total: 192414, 0: 185316, 1:   3220, 2:   1573, 4:    947, 8:    697, 16:    404, 32:    132, 64:     35, 128:     90
client: 8065 total: 205772, 0: 199587, 1:   2596, 2:   1324, 4:    899, 8:    713, 16:    386, 32:    136, 64:     46, 128:     85
client: 8066 total: 201973, 0: 195612, 1:   2613, 2:   1389, 4:    928, 8:    786, 16:    387, 32:    124, 64:     29, 128:    105
client: 8067 total: 166548, 0: 158598, 1:   3394, 2:   1830, 4:   1133, 8:    909, 16:    403, 32:    137, 64:     53, 128:     91
client: 8068 total: 223967, 0: 217559, 1:   2666, 2:   1381, 4:    958, 8:    733, 16:    425, 32:    130, 64:     41, 128:     74
client: 8069 total: 190651, 0: 184960, 1:   2365, 2:   1275, 4:    838, 8:    579, 16:    350, 32:    111, 64:     40, 128:    133
client: 8070 total: 209102, 0: 203178, 1:   2365, 2:   1336, 4:    926, 8:    700, 16:    339, 32:     98, 64:     20, 128:    140
client: 8071 total: 177921, 0: 170560, 1:   3157, 2:   1664, 4:   1181, 8:    776, 16:    325, 32:     94, 64:     50, 128:    114
client: 8072 total: 179407, 0: 171815, 1:   3507, 2:   1673, 4:    951, 8:    749, 16:    452, 32:    131, 64:     42, 128:     87
client: 8073 total:    801, 0:     95, 1:      4, 2:      3, 4:      6, 8:      5, 16:      3, 32:      4, 64:      7, 128:    674
client: 8074 total: 187788, 0: 181400, 1:   2577, 2:   1535, 4:    979, 8:    674, 16:    353, 32:    103, 64:     35, 128:    132
client: 8075 total: 160161, 0: 152337, 1:   3382, 2:   1797, 4:   1139, 8:    830, 16:    382, 32:    130, 64:     51, 128:    113
client: 8076 total: 183443, 0: 176245, 1:   3102, 2:   1670, 4:    972, 8:    756, 16:    440, 32:    120, 64:     37, 128:    101
client: 8077 total:    796, 0:     79, 1:      7, 2:      6, 4:      8, 8:      3, 16:      3, 32:      8, 64:     10, 128:    672
client: 8078 total: 199109, 0: 192478, 1:   2630, 2:   1493, 4:   1030, 8:    798, 16:    413, 32:    136, 64:     42, 128:     89
client: 8079 total: 196467, 0: 189511, 1:   2863, 2:   1588, 4:   1109, 8:    821, 16:    309, 32:    104, 64:     38, 128:    124
client: 8080 total: 205522, 0: 198965, 1:   2812, 2:   1406, 4:    926, 8:    674, 16:    486, 32:    132, 64:     37, 128:     84
client: 8081 total: 229116, 0: 222744, 1:   2555, 2:   1371, 4:    925, 8:    781, 16:    520, 32:    151, 64:     38, 128:     31
client: 8082 total: 225808, 0: 219978, 1:   2326, 2:   1274, 4:    935, 8:    690, 16:    346, 32:    121, 64:     38, 128:    100
client: 8083 total: 193709, 0: 186636, 1:   3057, 2:   1545, 4:   1094, 8:    782, 16:    324, 32:    119, 64:     46, 128:    106
client: 8084 total: 205218, 0: 199256, 1:   2421, 2:   1332, 4:    859, 8:    693, 16:    392, 32:    122, 64:     33, 128:    110
client: 8085 total: 191134, 0: 184666, 1:   2595, 2:   1519, 4:    926, 8:    689, 16:    477, 32:    136, 64:     45, 128:     81
client: 8086 total: 193092, 0: 186555, 1:   2795, 2:   1498, 4:    936, 8:    656, 16:    385, 32:    115, 64:     41, 128:    111
client: 8087 total: 170128, 0: 162650, 1:   3390, 2:   1700, 4:   1085, 8:    726, 16:    295, 32:    104, 64:     41, 128:    137
client: 8088 total: 202090, 0: 195919, 1:   2684, 2:   1378, 4:    880, 8:    616, 16:    330, 32:    126, 64:     41, 128:    116
client: 8089 total: 191086, 0: 184479, 1:   2854, 2:   1433, 4:    933, 8:    673, 16:    452, 32:    140, 64:     39, 128:     83
client: 8090 total: 237621, 0: 231570, 1:   2396, 2:   1316, 4:    966, 8:    732, 16:    405, 32:    121, 64:     37, 128:     78
client: 8091 total: 179095, 0: 172068, 1:   2930, 2:   1595, 4:   1135, 8:    758, 16:    328, 32:    109, 64:     45, 128:    127
client: 8092 total: 191448, 0: 184137, 1:   3310, 2:   1561, 4:    975, 8:    712, 16:    486, 32:    163, 64:     27, 128:     77
client: 8093 total: 216782, 0: 211072, 1:   2401, 2:   1202, 4:    837, 8:    660, 16:    355, 32:    122, 64:     41, 128:     92
client: 8094 total: 183654, 0: 177557, 1:   2448, 2:   1420, 4:    855, 8:    688, 16:    398, 32:    122, 64:     39, 128:    127
client: 8095 total: 190868, 0: 183676, 1:   2971, 2:   1627, 4:   1160, 8:    817, 16:    348, 32:    118, 64:     43, 128:    108
client: 8096 total: 176162, 0: 168853, 1:   3285, 2:   1629, 4:    978, 8:    726, 16:    428, 32:    116, 64:     44, 128:    103
client: 8097 total: 214428, 0: 207698, 1:   2742, 2:   1511, 4:    977, 8:    808, 16:    438, 32:    167, 64:     41, 128:     46
client: 8098 total: 195961, 0: 189339, 1:   2762, 2:   1475, 4:    932, 8:    753, 16:    413, 32:    163, 64:     28, 128:     96
client: 8099 total: 169085, 0: 161977, 1:   3096, 2:   1643, 4:   1035, 8:    727, 16:    304, 32:    119, 64:     49, 128:    135
client: 8100 total: 192446, 0: 186094, 1:   2795, 2:   1338, 4:    923, 8:    670, 16:    352, 32:    115, 64:     31, 128:    128
client: 8101 total: 219653, 0: 213812, 1:   2486, 2:   1182, 4:    838, 8:    717, 16:    372, 32:    132, 64:     31, 128:     83
client: 8102 total: 195028, 0: 188633, 1:   2637, 2:   1466, 4:    942, 8:    678, 16:    384, 32:    138, 64:     42, 128:    108
client: 8103 total: 164776, 0: 157047, 1:   3338, 2:   1773, 4:   1104, 8:    840, 16:    376, 32:    151, 64:     53, 128:     94
client: 8104 total:   3151, 0:   2369, 1:     19, 2:     21, 4:      7, 8:     13, 16:     16, 32:     16, 64:     20, 128:    670
client: 8105 total: 195378, 0: 189177, 1:   2587, 2:   1397, 4:    831, 8:    717, 16:    391, 32:    141, 64:     24, 128:    113
client: 8106 total:    747, 0:     46, 1:      3, 2:      1, 4:      3, 8:      1, 16:      4, 32:      4, 64:      4, 128:    681
client: 8107 total: 198212, 0: 189418, 1:   3992, 2:   2184, 4:   1232, 8:    846, 16:    311, 32:     94, 64:     38, 128:     97
client: 8108 total: 211511, 0: 204983, 1:   2828, 2:   1416, 4:    989, 8:    675, 16:    380, 32:    103, 64:     30, 128:    107
client: 8109 total: 204092, 0: 197622, 1:   2664, 2:   1470, 4:    897, 8:    721, 16:    454, 32:    157, 64:     24, 128:     83
client: 8110 total:    764, 0:     60, 1:      3, 2:      1, 4:      2, 8:      0, 16:      5, 32:      4, 64:      6, 128:    683
client: 8111 total: 193024, 0: 184405, 1:   3916, 2:   2047, 4:   1262, 8:    806, 16:    328, 32:    125, 64:     38, 128:     97
client: 8112 total: 202223, 0: 195502, 1:   2835, 2:   1508, 4:    966, 8:    736, 16:    423, 32:    129, 64:     37, 128:     87
client: 8113 total: 217014, 0: 211225, 1:   2339, 2:   1297, 4:    861, 8:    666, 16:    365, 32:    134, 64:     43, 128:     84
client: 8114 total: 203656, 0: 196931, 1:   2757, 2:   1500, 4:   1040, 8:    759, 16:    435, 32:    114, 64:     37, 128:     83
client: 8115 total: 175496, 0: 167710, 1:   3476, 2:   1721, 4:   1102, 8:    860, 16:    363, 32:    114, 64:     45, 128:    105
client: 8116 total: 208901, 0: 202884, 1:   2549, 2:   1268, 4:    905, 8:    697, 16:    341, 32:    108, 64:     30, 128:    119
client: 8117 total: 197603, 0: 191415, 1:   2575, 2:   1379, 4:    924, 8:    611, 16:    420, 32:    143, 64:     49, 128:     87
client: 8118 total: 207889, 0: 202032, 1:   2368, 2:   1298, 4:    905, 8:    661, 16:    349, 32:    112, 64:     34, 128:    130
client: 8119 total: 172456, 0: 165113, 1:   3126, 2:   1669, 4:   1148, 8:    783, 16:    339, 32:    123, 64:     32, 128:    123
client: 8120 total: 203588, 0: 196939, 1:   2919, 2:   1464, 4:    877, 8:    712, 16:    425, 32:    122, 64:     45, 128:     85
client: 8121 total: 194930, 0: 189163, 1:   2477, 2:   1204, 4:    833, 8:    646, 16:    329, 32:    122, 64:     33, 128:    123
client: 8122 total: 182088, 0: 175669, 1:   2580, 2:   1518, 4:    919, 8:    723, 16:    396, 32:    130, 64:     42, 128:    111
client: 8123 total:    993, 0:    267, 1:      6, 2:      4, 4:     10, 8:     18, 16:      8, 32:      2, 64:      2, 128:    676
client: 8124 total:    745, 0:     49, 1:      0, 2:      1, 4:      3, 8:      2, 16:      2, 32:      2, 64:      4, 128:    682
client: 8125 total: 186300, 0: 179881, 1:   2791, 2:   1356, 4:    927, 8:    659, 16:    406, 32:    146, 64:     45, 128:     89
client: 8126 total: 185359, 0: 178779, 1:   2775, 2:   1475, 4:    940, 8:    697, 16:    406, 32:    126, 64:     64, 128:     97
client: 8127 total: 166856, 0: 159496, 1:   3137, 2:   1684, 4:   1042, 8:    826, 16:    387, 32:    124, 64:     33, 128:    127

After
------
client: 8000 total:    826, 0:    113, 1:      8, 2:      8, 4:      3, 8:      2, 16:      1, 32:      9, 64:      6, 128:    676
client: 8001 total: 187479, 0: 180584, 1:   2867, 2:   1516, 4:   1142, 8:    722, 16:    399, 32:    116, 64:     33, 128:    100
client: 8002 total: 218099, 0: 212681, 1:   2224, 2:    957, 4:    865, 8:    723, 16:    422, 32:     89, 64:     19, 128:    119
client: 8003 total:    772, 0:     75, 1:      4, 2:      2, 4:      2, 8:      4, 16:      6, 32:      1, 64:      4, 128:    674
client: 8004 total: 217000, 0: 210967, 1:   2594, 2:   1292, 4:    921, 8:    609, 16:    378, 32:    131, 64:     44, 128:     64
client: 8005 total: 218804, 0: 211998, 1:   2742, 2:   1586, 4:   1136, 8:    762, 16:    381, 32:    115, 64:     26, 128:     58
client: 8006 total: 213593, 0: 206364, 1:   2945, 2:   1632, 4:   1114, 8:    900, 16:    461, 32:    102, 64:     21, 128:     54
client: 8007 total: 225687, 0: 219903, 1:   2401, 2:   1286, 4:    890, 8:    641, 16:    353, 32:    120, 64:     22, 128:     71
client: 8008 total: 206299, 0: 199848, 1:   2792, 2:   1418, 4:    913, 8:    668, 16:    412, 32:    145, 64:     31, 128:     72
client: 8009 total: 141460, 0: 134974, 1:   3226, 2:   1210, 4:    783, 8:    601, 16:    326, 32:     61, 64:     30, 128:    249
client: 8010 total: 218211, 0: 212780, 1:   2261, 2:   1108, 4:    830, 8:    639, 16:    346, 32:    136, 64:     32, 128:     79
client: 8011 total: 215633, 0: 209719, 1:   2502, 2:   1392, 4:    918, 8:    579, 16:    306, 32:     95, 64:     28, 128:     94
client: 8012 total: 214308, 0: 208234, 1:   2647, 2:   1323, 4:    896, 8:    621, 16:    361, 32:    118, 64:     26, 128:     82
client: 8013 total: 198949, 0: 191569, 1:   3089, 2:   1695, 4:   1166, 8:    791, 16:    425, 32:    124, 64:     22, 128:     68
client: 8014 total: 225869, 0: 219898, 1:   2444, 2:   1329, 4:    935, 8:    681, 16:    357, 32:    139, 64:     52, 128:     34
client: 8015 total: 236350, 0: 230533, 1:   2310, 2:   1314, 4:    936, 8:    688, 16:    384, 32:    107, 64:     33, 128:     45
client: 8016 total: 190757, 0: 184435, 1:   2660, 2:   1447, 4:    899, 8:    658, 16:    375, 32:    162, 64:     32, 128:     89
client: 8017 total:   1145, 0:    405, 1:     12, 2:      4, 4:      6, 8:     19, 16:     18, 32:      2, 64:      1, 128:    678
client: 8018 total: 206997, 0: 200262, 1:   2863, 2:   1509, 4:   1065, 8:    718, 16:    356, 32:    129, 64:     30, 128:     65
client: 8019 total: 226798, 0: 220975, 1:   2386, 2:   1307, 4:    903, 8:    655, 16:    351, 32:    120, 64:     32, 128:     69
client: 8020 total: 240272, 0: 234430, 1:   2377, 2:   1222, 4:    853, 8:    731, 16:    451, 32:    132, 64:     40, 128:     36
client: 8021 total: 205954, 0: 199098, 1:   2915, 2:   1480, 4:   1079, 8:    758, 16:    416, 32:    109, 64:     28, 128:     71
client: 8022 total: 224141, 0: 218573, 1:   2247, 2:   1232, 4:    879, 8:    636, 16:    346, 32:    127, 64:     31, 128:     70
client: 8023 total: 222299, 0: 216070, 1:   2613, 2:   1412, 4:    909, 8:    698, 16:    373, 32:    150, 64:     27, 128:     47
client: 8024 total: 198426, 0: 192316, 1:   2630, 2:   1295, 4:    853, 8:    659, 16:    412, 32:    137, 64:     38, 128:     86
client: 8025 total: 220631, 0: 214085, 1:   2786, 2:   1444, 4:   1015, 8:    744, 16:    346, 32:    114, 64:     28, 128:     69
client: 8026 total:  74213, 0:  72214, 1:    624, 2:    324, 4:    279, 8:    175, 16:     58, 32:     24, 64:     11, 128:    504
client: 8027 total: 217572, 0: 212055, 1:   2255, 2:   1214, 4:    839, 8:    668, 16:    320, 32:    110, 64:     18, 128:     93
client: 8028 total: 218263, 0: 212325, 1:   2514, 2:   1340, 4:    895, 8:    609, 16:    343, 32:    123, 64:     31, 128:     83
client: 8029 total: 195349, 0: 188353, 1:   3131, 2:   1539, 4:   1054, 8:    711, 16:    334, 32:    109, 64:     31, 128:     87
client: 8030 total: 222428, 0: 217414, 1:   1939, 2:   1060, 4:    854, 8:    595, 16:    336, 32:    113, 64:     33, 128:     84
client: 8031 total: 205126, 0: 199365, 1:   2471, 2:   1337, 4:    864, 8:    526, 16:    315, 32:    116, 64:     33, 128:     99
client: 8032 total: 215655, 0: 209182, 1:   2823, 2:   1502, 4:    967, 8:    614, 16:    340, 32:    123, 64:     41, 128:     63
client: 8033 total: 216838, 0: 210673, 1:   2419, 2:   1400, 4:   1026, 8:    709, 16:    392, 32:    126, 64:     38, 128:     55
client: 8034 total: 216907, 0: 211076, 1:   2345, 2:   1252, 4:    951, 8:    707, 16:    343, 32:    141, 64:     36, 128:     56
client: 8035 total: 217258, 0: 211130, 1:   2613, 2:   1374, 4:    955, 8:    647, 16:    335, 32:    102, 64:     33, 128:     69
client: 8036 total:    892, 0:    159, 1:      8, 2:     11, 4:      6, 8:     13, 16:     10, 32:      5, 64:      6, 128:    674
client: 8037 total: 168185, 0: 163818, 1:   1450, 2:    781, 4:    760, 8:    621, 16:    391, 32:     76, 64:     29, 128:    259
client: 8038 total: 233536, 0: 228013, 1:   2236, 2:   1246, 4:    847, 8:    650, 16:    354, 32:     99, 64:     34, 128:     57
client: 8039 total:    785, 0:     74, 1:      9, 2:      4, 4:      2, 8:      4, 16:      5, 32:      6, 64:      7, 128:    674
client: 8040 total: 209903, 0: 202741, 1:   3226, 2:   1511, 4:   1002, 8:    758, 16:    420, 32:    145, 64:     33, 128:     67
client: 8041 total:  60905, 0:  58483, 1:    968, 2:    446, 4:    233, 8:    149, 16:     68, 32:     20, 64:     28, 128:    510
client: 8042 total: 218146, 0: 212491, 1:   2340, 2:   1163, 4:    915, 8:    655, 16:    357, 32:    108, 64:     33, 128:     84
client: 8043 total: 220248, 0: 214512, 1:   2318, 2:   1238, 4:    935, 8:    675, 16:    325, 32:    137, 64:     43, 128:     65
client: 8044 total: 228576, 0: 222838, 1:   2319, 2:   1286, 4:    847, 8:    690, 16:    384, 32:    119, 64:     28, 128:     65
client: 8045 total: 215406, 0: 210699, 1:   1570, 2:   1008, 4:    865, 8:    672, 16:    314, 32:    109, 64:     16, 128:    153
client: 8046 total: 211941, 0: 206837, 1:   2082, 2:   1120, 4:    803, 8:    585, 16:    280, 32:     81, 64:     35, 128:    118
client: 8047 total:    751, 0:     55, 1:      2, 2:      3, 4:      4, 8:      5, 16:      1, 32:      2, 64:      6, 128:    673
client: 8048 total: 216334, 0: 211585, 1:   1920, 2:    944, 4:    725, 8:    527, 16:    367, 32:    129, 64:     30, 128:    107
client: 8049 total: 209452, 0: 203392, 1:   2599, 2:   1323, 4:    940, 8:    625, 16:    338, 32:    103, 64:     36, 128:     96
client: 8050 total: 221092, 0: 215941, 1:   1991, 2:   1099, 4:    855, 8:    611, 16:    361, 32:    124, 64:     32, 128:     78
client: 8051 total: 214427, 0: 209076, 1:   2147, 2:   1261, 4:    838, 8:    537, 16:    327, 32:    109, 64:     26, 128:    106
client: 8052 total: 209110, 0: 203588, 1:   2237, 2:   1274, 4:    830, 8:    591, 16:    328, 32:    124, 64:     30, 128:    108
client: 8053 total: 214102, 0: 207888, 1:   2630, 2:   1397, 4:    976, 8:    643, 16:    344, 32:    103, 64:     36, 128:     85
client: 8054 total: 226241, 0: 220167, 1:   2477, 2:   1450, 4:    950, 8:    675, 16:    318, 32:    107, 64:     27, 128:     70
client: 8055 total: 216226, 0: 210305, 1:   2487, 2:   1343, 4:    881, 8:    610, 16:    355, 32:    141, 64:     41, 128:     63
client: 8056 total: 212978, 0: 206439, 1:   2782, 2:   1526, 4:    950, 8:    679, 16:    354, 32:    147, 64:     44, 128:     57
client: 8057 total: 223873, 0: 217261, 1:   2676, 2:   1536, 4:   1033, 8:    794, 16:    376, 32:    115, 64:     27, 128:     55
client: 8058 total: 225306, 0: 219020, 1:   2567, 2:   1417, 4:    996, 8:    701, 16:    407, 32:    119, 64:     38, 128:     41
client: 8059 total: 232767, 0: 228125, 1:   1638, 2:    942, 4:    812, 8:    686, 16:    349, 32:     79, 64:     20, 128:    116
client: 8060 total: 182886, 0: 174937, 1:   3590, 2:   1729, 4:   1102, 8:    806, 16:    483, 32:    146, 64:     37, 128:     56
client: 8061 total: 213775, 0: 207061, 1:   2730, 2:   1521, 4:   1123, 8:    731, 16:    402, 32:    123, 64:     37, 128:     47
client: 8062 total: 224452, 0: 218559, 1:   2431, 2:   1251, 4:    953, 8:    668, 16:    382, 32:    120, 64:     41, 128:     47
client: 8063 total: 230913, 0: 224881, 1:   2490, 2:   1333, 4:    913, 8:    732, 16:    361, 32:    115, 64:     17, 128:     71
client: 8064 total: 227459, 0: 221552, 1:   2488, 2:   1295, 4:    866, 8:    681, 16:    356, 32:    116, 64:     43, 128:     62
client: 8065 total: 220354, 0: 214140, 1:   2485, 2:   1406, 4:   1094, 8:    677, 16:    332, 32:    118, 64:     41, 128:     61
client: 8066 total: 225227, 0: 219540, 1:   2227, 2:   1276, 4:    934, 8:    667, 16:    361, 32:    127, 64:     36, 128:     59
client: 8067 total: 194002, 0: 188130, 1:   2500, 2:   1319, 4:    917, 8:    569, 16:    306, 32:    111, 64:     31, 128:    119
client: 8068 total: 215053, 0: 209164, 1:   2437, 2:   1282, 4:    931, 8:    625, 16:    365, 32:    148, 64:     45, 128:     56
client: 8069 total: 209049, 0: 202544, 1:   2697, 2:   1453, 4:   1067, 8:    716, 16:    348, 32:    118, 64:     40, 128:     66
client: 8070 total: 224840, 0: 218293, 1:   2725, 2:   1439, 4:   1024, 8:    768, 16:    413, 32:    110, 64:     24, 128:     44
client: 8071 total: 219303, 0: 212725, 1:   2844, 2:   1431, 4:    970, 8:    745, 16:    381, 32:    132, 64:     28, 128:     47
client: 8072 total: 218213, 0: 212357, 1:   2487, 2:   1355, 4:    846, 8:    582, 16:    352, 32:    120, 64:     28, 128:     86
client: 8073 total: 203373, 0: 196998, 1:   2682, 2:   1360, 4:    999, 8:    700, 16:    414, 32:    114, 64:     33, 128:     73
client: 8074 total: 226430, 0: 220875, 1:   2207, 2:   1252, 4:    926, 8:    676, 16:    306, 32:     71, 64:     34, 128:     83
client: 8075 total: 211444, 0: 205329, 1:   2622, 2:   1410, 4:    918, 8:    653, 16:    288, 32:    111, 64:     30, 128:     83
client: 8076 total: 221535, 0: 215699, 1:   2503, 2:   1252, 4:    890, 8:    607, 16:    356, 32:    117, 64:     38, 128:     73
client: 8077 total: 220035, 0: 214364, 1:   2240, 2:   1241, 4:    948, 8:    660, 16:    351, 32:    111, 64:     39, 128:     81
client: 8078 total: 221190, 0: 215154, 1:   2654, 2:   1351, 4:    898, 8:    648, 16:    294, 32:     83, 64:     22, 128:     86
client: 8079 total: 223874, 0: 217901, 1:   2518, 2:   1328, 4:    895, 8:    643, 16:    389, 32:    119, 64:     36, 128:     45
client: 8080 total: 210692, 0: 204650, 1:   2561, 2:   1390, 4:    921, 8:    594, 16:    339, 32:    115, 64:     26, 128:     96
client: 8081 total: 207248, 0: 200853, 1:   2630, 2:   1459, 4:    987, 8:    728, 16:    361, 32:    117, 64:     33, 128:     80
client: 8082 total: 205767, 0: 198328, 1:   3210, 2:   1671, 4:   1105, 8:    834, 16:    425, 32:    112, 64:     27, 128:     55
client: 8083 total: 215896, 0: 210398, 1:   2237, 2:   1273, 4:    837, 8:    607, 16:    321, 32:     97, 64:     31, 128:     95
client: 8084 total:  87046, 0:  84258, 1:   1238, 2:    481, 4:    324, 8:    175, 16:     64, 32:     29, 64:     15, 128:    462
client: 8085 total: 193786, 0: 186755, 1:   3414, 2:   1415, 4:    899, 8:    689, 16:    379, 32:     81, 64:     21, 128:    133
client: 8086 total: 224098, 0: 217866, 1:   2591, 2:   1344, 4:    948, 8:    759, 16:    386, 32:    139, 64:     31, 128:     34
client: 8087 total: 222304, 0: 216511, 1:   2508, 2:   1261, 4:    836, 8:    635, 16:    361, 32:     87, 64:     30, 128:     75
client: 8088 total: 236297, 0: 230406, 1:   2385, 2:   1277, 4:    923, 8:    686, 16:    406, 32:    140, 64:     33, 128:     41
client: 8089 total: 211643, 0: 205052, 1:   2665, 2:   1492, 4:   1127, 8:    737, 16:    368, 32:    100, 64:     29, 128:     73
client: 8090 total: 232231, 0: 225965, 1:   2571, 2:   1318, 4:    993, 8:    762, 16:    424, 32:    135, 64:     32, 128:     31
client: 8091 total: 209019, 0: 202298, 1:   2841, 2:   1375, 4:   1030, 8:    818, 16:    455, 32:     92, 64:     19, 128:     91
client: 8092 total: 212086, 0: 205590, 1:   2849, 2:   1482, 4:    927, 8:    629, 16:    372, 32:    127, 64:     47, 128:     63
client: 8093 total: 217893, 0: 211074, 1:   2849, 2:   1387, 4:   1121, 8:    826, 16:    429, 32:    103, 64:     30, 128:     74
client: 8094 total: 195241, 0: 192199, 1:    585, 2:    554, 4:    602, 8:    602, 16:    357, 32:     78, 64:     17, 128:    247
client: 8095 total: 220209, 0: 214317, 1:   2457, 2:   1352, 4:    839, 8:    648, 16:    366, 32:    132, 64:     34, 128:     64
client: 8096 total: 219150, 0: 213091, 1:   2515, 2:   1349, 4:    936, 8:    663, 16:    359, 32:    141, 64:     31, 128:     65
client: 8097 total: 232578, 0: 227631, 1:   1648, 2:   1092, 4:    888, 8:    704, 16:    409, 32:     80, 64:     21, 128:    105
client: 8098 total: 216775, 0: 210992, 1:   2382, 2:   1296, 4:    852, 8:    718, 16:    311, 32:    115, 64:     30, 128:     79
client: 8099 total: 229158, 0: 223753, 1:   2156, 2:   1213, 4:    875, 8:    636, 16:    317, 32:     93, 64:     22, 128:     93
client: 8100 total: 208238, 0: 202766, 1:   2322, 2:   1185, 4:    782, 8:    571, 16:    349, 32:    124, 64:     28, 128:    111
client: 8101 total: 207255, 0: 201375, 1:   2329, 2:   1381, 4:    987, 8:    620, 16:    321, 32:    111, 64:     33, 128:     98
client: 8102 total: 226474, 0: 220582, 1:   2439, 2:   1320, 4:    945, 8:    688, 16:    312, 32:     95, 64:     17, 128:     76
client: 8103 total: 232852, 0: 227275, 1:   2246, 2:   1209, 4:    890, 8:    693, 16:    334, 32:    119, 64:     37, 128:     49
client: 8104 total: 216731, 0: 210048, 1:   2919, 2:   1548, 4:    933, 8:    656, 16:    393, 32:    146, 64:     42, 128:     46
client: 8105 total: 203953, 0: 196757, 1:   3079, 2:   1597, 4:   1128, 8:    774, 16:    394, 32:    127, 64:     33, 128:     64
client: 8106 total: 225447, 0: 219508, 1:   2406, 2:   1348, 4:    978, 8:    644, 16:    343, 32:    128, 64:     35, 128:     57
client: 8107 total: 216212, 0: 210273, 1:   2587, 2:   1370, 4:    848, 8:    598, 16:    311, 32:    103, 64:     38, 128:     84
client: 8108 total: 209421, 0: 202370, 1:   3105, 2:   1553, 4:    977, 8:    732, 16:    462, 32:    134, 64:     20, 128:     68
client: 8109 total: 192910, 0: 185879, 1:   2946, 2:   1555, 4:   1116, 8:    807, 16:    378, 32:    129, 64:     33, 128:     67
client: 8110 total: 221571, 0: 215820, 1:   2369, 2:   1268, 4:    921, 8:    668, 16:    332, 32:     78, 64:     29, 128:     86
client: 8111 total: 217168, 0: 209860, 1:   3204, 2:   1605, 4:   1080, 8:    794, 16:    422, 32:    137, 64:     23, 128:     43
client: 8112 total: 219046, 0: 212406, 1:   2849, 2:   1564, 4:    921, 8:    668, 16:    410, 32:    141, 64:     50, 128:     37
client: 8113 total: 214189, 0: 207319, 1:   2822, 2:   1538, 4:   1140, 8:    769, 16:    394, 32:    119, 64:     35, 128:     53
client: 8114 total:  78876, 0:  76209, 1:   1200, 2:    444, 4:    274, 8:    173, 16:     47, 32:     22, 64:     10, 128:    497
client: 8115 total: 184834, 0: 177229, 1:   3360, 2:   1697, 4:   1066, 8:    790, 16:    448, 32:    150, 64:     40, 128:     54
client: 8116 total:  68876, 0:     94, 1:      5, 2:      2, 4:      2, 8:      6, 16:      6, 32:      4, 64:      0, 128:    62
client: 8117 total: 220961, 0: 215074, 1:   2341, 2:   1305, 4:    963, 8:    662, 16:    385, 32:    126, 64:     35, 128:     70
client: 8118 total:    797, 0:     94, 1:      5, 2:      2, 4:      2, 8:      6, 16:      6, 32:      4, 64:      0, 128:    678
client: 8119 total: 211943, 0: 205822, 1:   2616, 2:   1396, 4:    897, 8:    628, 16:    343, 32:    129, 64:     44, 128:     68
client: 8120 total: 209269, 0: 202188, 1:   3195, 2:   1445, 4:    985, 8:    749, 16:    499, 32:    115, 64:     22, 128:     71
client: 8121 total: 214751, 0: 208175, 1:   2757, 2:   1503, 4:   1041, 8:    686, 16:    365, 32:    113, 64:     36, 128:     75
client: 8122 total: 231016, 0: 225169, 1:   2282, 2:   1299, 4:    968, 8:    709, 16:    378, 32:    140, 64:     38, 128:     33
client: 8123 total: 215626, 0: 209266, 1:   2645, 2:   1443, 4:    942, 8:    745, 16:    367, 32:    129, 64:     41, 128:     48
client: 8124 total: 222754, 0: 216959, 1:   2415, 2:   1303, 4:    910, 8:    597, 16:    334, 32:    121, 64:     47, 128:     68
client: 8125 total: 218399, 0: 212569, 1:   2214, 2:   1305, 4:    975, 8:    710, 16:    396, 32:    118, 64:     41, 128:     71
client: 8126 total: 222317, 0: 216123, 1:   2583, 2:   1380, 4:    922, 8:    712, 16:    383, 32:    134, 64:     38, 128:     42
client: 8127 total: 219996, 0: 213620, 1:   2779, 2:   1445, 4:    899, 8:    668, 16:    370, 32:    132, 64:     25, 128:     58

-- 
Best regards,
Ridong


