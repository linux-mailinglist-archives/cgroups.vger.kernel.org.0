Return-Path: <cgroups+bounces-13338-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ4XCi2GcGkEYQAAu9opvQ
	(envelope-from <cgroups+bounces-13338-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 08:54:21 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FB65317B
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 08:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FC93348001
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 07:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E546AED1;
	Wed, 21 Jan 2026 07:53:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3DA46AED6;
	Wed, 21 Jan 2026 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768982001; cv=none; b=VRsZkNxXKqSEo3TNOwf5guQKhiYOsgFBSF8k+266BnIy2bPhVZdRhDhX3/tPvHUkCiffUYZXTuY6S7qDu26I4DnrfG49g1iWq97PEa+AZjaGIZOk5wcz0IZqp/99K0p6iXxILdulTldllILXKIyieSrwbIOI+/panw0JBIoaNg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768982001; c=relaxed/simple;
	bh=ZnphPD9EtahcPp+gJ22HutJXYG0lP2uVTwpDRM35uGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/HsMCv4L87QCbfIUrmh94ESovgjyLjZPpl9NPyJM3bQHK85yMMrSb5/SUcoQYuvvtgkGfTHAV+HmhTjfy4jim1fn4xNLXpd5jchjt1/T2wVuGfgRR9pAEqEpBHDhlkmfykDMDGKftBbas72L+yKoWbmXUJTE15/+AGr1qkcCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dwxJS1HDyzKHrpc;
	Wed, 21 Jan 2026 15:53:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9343740573;
	Wed, 21 Jan 2026 15:53:13 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgDXhfbnhXBpZ7ZKEg--.52232S2;
	Wed, 21 Jan 2026 15:53:13 +0800 (CST)
Message-ID: <6561bee6-fbe3-4f59-bc4d-17ec56768d3c@huaweicloud.com>
Date: Wed, 21 Jan 2026 15:53:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 1/7] vmscan: add memcg heat level for reclaim
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
 <20260120134256.2271710-2-chenridong@huaweicloud.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260120134256.2271710-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXhfbnhXBpZ7ZKEg--.52232S2
X-Coremail-Antispam: 1UD129KBjvAXoWfCF1DArW5uF1Utr1fCr1DAwb_yoW5Zw4kJo
	Wxtw1jva1qg3s8Cw1vya13WF4Y9Fn3Zws5Zw1DJrW8K3W3Cws5A3WfWa47Kw15ZrWSyayk
	Zws8Z3WrJw4xGFn7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY77kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
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
	TAGGED_FROM(0.00)[bounces-13338-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,huawei.com:email,localhost:email,huaweicloud.com:mid,client.py:url,common.by:url]
X-Rspamd-Queue-Id: 97FB65317B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/1/20 21:42, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The memcg LRU was originally introduced to improve scalability during
> global reclaim. However, it is complex and only works with gen lru
> global reclaim. Moreover, its implementation complexity has led to
> performance regressions when handling a large number of memory cgroups [1].
> 
> This patch introduces a per-memcg heat level for reclaim, aiming to unify
> gen lru and traditional LRU global reclaim. The core idea is to track
> per-node per-memcg reclaim state, including heat, last_decay, and
> last_refault. The last_refault records the total reclaimed data from the
> previous memcg reclaim. The last_decay is a time-based parameter; the heat
> level decays over time if the memcg is not reclaimed again. Both last_decay
> and last_refault are used to calculate the current heat level when reclaim
> starts.
> 
> Three reclaim heat levels are defined: cold, warm, and hot. Cold memcgs are
> reclaimed first; only if cold memcgs cannot reclaim enough pages, warm
> memcgs become eligible for reclaim. Hot memcgs are reclaimed last.
> 
> While this design can be applied to all memcg reclaim scenarios, this patch
> is conservative and only introduces heat levels for traditional LRU global
> reclaim. Subsequent patches will replace the memcg LRU with
> heat-level-based reclaim.
> 
> Based on tests provided by YU Zhao, traditional LRU global reclaim shows
> significant performance improvement with heat-level reclaim enabled.
> 
> The results below are from a 2-hour run of the test [2].
> 
> Throughput (number of requests)		before	   after	Change
> Total					1734169    2353717	+35%
> 
> Tail latency (number of requests)	before	   after	Change
> [128s, inf)				1231	   1057		-14%
> [64s, 128s)				586	   444		-24%
> [32s, 64s)				1658	   1061		-36%
> [16s, 32s)				4611	   2863		-38%
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

sleep $((2 * 60 * 60))
trap 'wait' SIGINT
kill -INT 0
```
Results(run 2h)
=======
Before
------
client: 8000 total:   5833, 0:   5624, 1:     49, 2:     43, 4:     32, 8:     18, 16:     17, 32:     14, 64:      2, 128:     34
client: 8001 total:  14862, 0:  14256, 1:    175, 2:    148, 4:    116, 8:     94, 16:     49, 32:     19, 64:      4, 128:      1
client: 8002 total:  18719, 0:  18160, 1:    172, 2:    118, 4:    112, 8:    111, 16:     25, 32:     16, 64:      4, 128:      1
client: 8003 total:  12010, 0:  11524, 1:    122, 2:    107, 4:    106, 8:     80, 16:     43, 32:     13, 64:      3, 128:     12
client: 8004 total:  15991, 0:  15529, 1:    135, 2:    113, 4:     94, 8:     58, 16:     37, 32:     10, 64:     11, 128:      4
client: 8005 total:  10693, 0:  10168, 1:    178, 2:    107, 4:     99, 8:     67, 16:     41, 32:     15, 64:      7, 128:     11
client: 8006 total:    138, 0:     64, 1:      3, 2:      5, 4:      0, 8:      3, 16:      3, 32:      3, 64:      4, 128:     53
client: 8007 total:  14807, 0:  14282, 1:    164, 2:    114, 4:    103, 8:     90, 16:     25, 32:     16, 64:      6, 128:      7
client: 8008 total:  18257, 0:  17700, 1:    169, 2:    130, 4:    114, 8:     84, 16:     37, 32:     20, 64:      3, 128:      0
client: 8009 total:    126, 0:     53, 1:      2, 2:      2, 4:      3, 8:      4, 16:      1, 32:      7, 64:      2, 128:     52
client: 8010 total:  17669, 0:  17160, 1:    163, 2:     99, 4:    123, 8:     68, 16:     37, 32:     11, 64:      5, 128:      3
client: 8011 total:  13321, 0:  12763, 1:    161, 2:    115, 4:    121, 8:    100, 16:     38, 32:     11, 64:      9, 128:      3
client: 8012 total:  14495, 0:  14050, 1:    119, 2:    115, 4:     90, 8:     73, 16:     28, 32:      6, 64:      2, 128:     12
client: 8013 total:    141, 0:     63, 1:      3, 2:      3, 4:      4, 8:      3, 16:      3, 32:      4, 64:      8, 128:     50
client: 8014 total:  17179, 0:  16681, 1:    165, 2:    106, 4:    100, 8:     73, 16:     31, 32:     14, 64:      4, 128:      5
client: 8015 total:  13015, 0:  12451, 1:    162, 2:    111, 4:    123, 8:    103, 16:     35, 32:     19, 64:      6, 128:      5
client: 8016 total:  15668, 0:  15183, 1:    143, 2:    117, 4:    101, 8:     66, 16:     36, 32:      9, 64:      4, 128:      9
client: 8017 total:  13804, 0:  13238, 1:    160, 2:    117, 4:    118, 8:     91, 16:     51, 32:     20, 64:      7, 128:      2
client: 8018 total:  17278, 0:  16733, 1:    158, 2:    128, 4:    110, 8:     88, 16:     47, 32:      9, 64:      1, 128:      4
client: 8019 total:  14696, 0:  14115, 1:    163, 2:    140, 4:    130, 8:     90, 16:     33, 32:     15, 64:      4, 128:      6
client: 8020 total:  16383, 0:  15816, 1:    181, 2:    147, 4:    110, 8:     68, 16:     41, 32:     13, 64:      5, 128:      2
client: 8021 total:  13550, 0:  12928, 1:    198, 2:    147, 4:     96, 8:    104, 16:     50, 32:     19, 64:      3, 128:      5
client: 8022 total:  17587, 0:  17053, 1:    160, 2:    112, 4:    131, 8:     84, 16:     30, 32:      6, 64:      8, 128:      3
client: 8023 total:  12916, 0:  12418, 1:    145, 2:    107, 4:    103, 8:     70, 16:     42, 32:     14, 64:      9, 128:      8
client: 8024 total:  16559, 0:  15965, 1:    181, 2:    143, 4:    127, 8:     77, 16:     44, 32:     19, 64:      3, 128:      0
client: 8025 total:  11129, 0:  10603, 1:    141, 2:    117, 4:    112, 8:     85, 16:     43, 32:     14, 64:      6, 128:      8
client: 8026 total:  15903, 0:  15412, 1:    156, 2:    116, 4:     85, 8:     64, 16:     44, 32:     15, 64:      6, 128:      5
client: 8027 total:  14609, 0:  14013, 1:    166, 2:    158, 4:     97, 8:    103, 16:     43, 32:     22, 64:      7, 128:      0
client: 8028 total:    120, 0:     54, 1:      0, 2:      0, 4:      1, 8:      1, 16:      4, 32:      3, 64:      4, 128:     53
client: 8029 total:  14575, 0:  13926, 1:    202, 2:    156, 4:    136, 8:     87, 16:     43, 32:     16, 64:      5, 128:      4
client: 8030 total:  17857, 0:  17341, 1:    140, 2:    125, 4:    106, 8:     85, 16:     41, 32:     11, 64:      6, 128:      2
client: 8031 total:  14276, 0:  13660, 1:    169, 2:    130, 4:    151, 8:     93, 16:     51, 32:     15, 64:      4, 128:      3
client: 8032 total:  14026, 0:  13372, 1:    227, 2:    158, 4:    123, 8:     84, 16:     43, 32:     10, 64:      5, 128:      4
client: 8033 total:  15025, 0:  14387, 1:    182, 2:    151, 4:    144, 8:     96, 16:     47, 32:     10, 64:      4, 128:      4
client: 8034 total:  14369, 0:  14001, 1:     96, 2:     89, 4:     69, 8:     49, 16:     35, 32:     12, 64:      4, 128:     14
client: 8035 total:  14531, 0:  14069, 1:    123, 2:    102, 4:     94, 8:     77, 16:     32, 32:     23, 64:      5, 128:      6
client: 8036 total:  10785, 0:  10289, 1:    124, 2:    138, 4:    100, 8:     66, 16:     34, 32:     15, 64:      2, 128:     17
client: 8037 total:  12991, 0:  12504, 1:    135, 2:    100, 4:    110, 8:     67, 16:     51, 32:      7, 64:      7, 128:     10
client: 8038 total:    418, 0:    313, 1:     11, 2:      8, 4:     10, 8:      9, 16:      7, 32:      8, 64:      4, 128:     48
client: 8039 total:  14650, 0:  14058, 1:    169, 2:    130, 4:    123, 8:     92, 16:     55, 32:     17, 64:      2, 128:      4
client: 8040 total:  14276, 0:  13646, 1:    211, 2:    146, 4:    133, 8:     80, 16:     40, 32:     13, 64:      3, 128:      4
client: 8041 total:  14555, 0:  13951, 1:    202, 2:    136, 4:    117, 8:     87, 16:     34, 32:     18, 64:      7, 128:      3
client: 8042 total:  14046, 0:  13491, 1:    165, 2:    132, 4:    101, 8:     99, 16:     34, 32:     14, 64:      6, 128:      4
client: 8043 total:  14914, 0:  14348, 1:    168, 2:    128, 4:    113, 8:     86, 16:     46, 32:     18, 64:      4, 128:      3
client: 8044 total:  18829, 0:  18172, 1:    182, 2:    178, 4:    150, 8:     91, 16:     42, 32:     14, 64:      0, 128:      0
client: 8045 total:  14583, 0:  14004, 1:    198, 2:    110, 4:    119, 8:     81, 16:     43, 32:     18, 64:      7, 128:      3
client: 8046 total:  16892, 0:  16328, 1:    176, 2:    139, 4:    108, 8:     85, 16:     38, 32:     11, 64:      2, 128:      5
client: 8047 total:  15658, 0:  15082, 1:    179, 2:    127, 4:    124, 8:     75, 16:     47, 32:     16, 64:      6, 128:      2
client: 8048 total:  18318, 0:  17713, 1:    184, 2:    147, 4:    143, 8:     77, 16:     38, 32:     11, 64:      4, 128:      1
client: 8049 total:  14599, 0:  13960, 1:    212, 2:    118, 4:    141, 8:    113, 16:     31, 32:     18, 64:      5, 128:      1
client: 8050 total:  16382, 0:  15913, 1:    142, 2:    103, 4:     97, 8:     82, 16:     24, 32:     14, 64:      3, 128:      4
client: 8051 total:  10185, 0:   9657, 1:    156, 2:    108, 4:    101, 8:     95, 16:     37, 32:     14, 64:      2, 128:     15
client: 8052 total:  17210, 0:  16658, 1:    165, 2:    134, 4:    118, 8:     73, 16:     47, 32:      9, 64:      5, 128:      1
client: 8053 total:  10534, 0:  10043, 1:    134, 2:    107, 4:    103, 8:     88, 16:     28, 32:     16, 64:      5, 128:     10
client: 8054 total:  12906, 0:  12451, 1:    130, 2:    103, 4:     94, 8:     70, 16:     31, 32:     12, 64:      7, 128:      8
client: 8055 total:  15115, 0:  14492, 1:    192, 2:    152, 4:    131, 8:     77, 16:     45, 32:     18, 64:      6, 128:      2
client: 8056 total:   6574, 0:   6206, 1:     95, 2:     81, 4:     59, 8:     65, 16:     30, 32:      6, 64:      2, 128:     30
client: 8057 total:  15547, 0:  14932, 1:    194, 2:    140, 4:    126, 8:     81, 16:     50, 32:     19, 64:      2, 128:      3
client: 8058 total:  17972, 0:  17438, 1:    160, 2:    120, 4:    106, 8:     88, 16:     45, 32:     10, 64:      4, 128:      1
client: 8059 total:    132, 0:     64, 1:      2, 2:      0, 4:      1, 8:      4, 16:      2, 32:      5, 64:      1, 128:     53
client: 8060 total:  17869, 0:  17225, 1:    212, 2:    152, 4:    133, 8:     94, 16:     40, 32:     11, 64:      2, 128:      0
client: 8061 total:  15195, 0:  14569, 1:    204, 2:    143, 4:    122, 8:     84, 16:     44, 32:     23, 64:      5, 128:      1
client: 8062 total:   4702, 0:   4435, 1:     72, 2:     45, 4:     56, 8:     34, 16:     16, 32:      5, 64:      5, 128:     34
client: 8063 total:   9854, 0:   9361, 1:    121, 2:    106, 4:    117, 8:     70, 16:     43, 32:     17, 64:      6, 128:     13
client: 8064 total:  15976, 0:  15365, 1:    204, 2:    151, 4:    107, 8:     84, 16:     43, 32:     16, 64:      6, 128:      0
client: 8065 total:  14062, 0:  13493, 1:    162, 2:    132, 4:    101, 8:    100, 16:     51, 32:     15, 64:      6, 128:      2
client: 8066 total:    138, 0:     70, 1:      3, 2:      1, 4:      1, 8:      1, 16:      2, 32:      5, 64:      3, 128:     52
client: 8067 total:  15074, 0:  14482, 1:    160, 2:    138, 4:    139, 8:     88, 16:     42, 32:     16, 64:      6, 128:      3
client: 8068 total:  18564, 0:  18065, 1:    142, 2:    142, 4:     97, 8:     69, 16:     26, 32:     15, 64:      3, 128:      5
client: 8069 total:  15186, 0:  14548, 1:    189, 2:    137, 4:    150, 8:     94, 16:     45, 32:     18, 64:      4, 128:      1
client: 8070 total:  16936, 0:  16355, 1:    207, 2:    116, 4:    129, 8:     71, 16:     37, 32:     15, 64:      4, 128:      2
client: 8071 total:  15182, 0:  14521, 1:    214, 2:    147, 4:    124, 8:    103, 16:     49, 32:     20, 64:      4, 128:      0
client: 8072 total:  17663, 0:  17160, 1:    162, 2:    130, 4:    106, 8:     51, 16:     28, 32:     15, 64:      8, 128:      3
client: 8073 total:  15204, 0:  14634, 1:    173, 2:    134, 4:    127, 8:     79, 16:     32, 32:     13, 64:      9, 128:      3
client: 8074 total:  13763, 0:  13391, 1:     93, 2:     77, 4:     79, 8:     62, 16:     34, 32:     11, 64:      4, 128:     12
client: 8075 total:   4408, 0:   4111, 1:     78, 2:     57, 4:     52, 8:     41, 16:     28, 32:      6, 64:      6, 128:     29
client: 8076 total:  17754, 0:  17211, 1:    171, 2:    135, 4:    107, 8:     73, 16:     37, 32:     15, 64:      3, 128:      2
client: 8077 total:   5200, 0:   4911, 1:     84, 2:     49, 4:     53, 8:     33, 16:     22, 32:      8, 64:     10, 128:     30
client: 8078 total:  17384, 0:  16864, 1:    163, 2:    119, 4:    100, 8:     81, 16:     33, 32:     16, 64:      5, 128:      3
client: 8079 total:  15168, 0:  14605, 1:    182, 2:    114, 4:    120, 8:     86, 16:     34, 32:     17, 64:      5, 128:      5
client: 8080 total:  15633, 0:  15074, 1:    147, 2:    147, 4:    132, 8:     84, 16:     30, 32:      9, 64:      6, 128:      4
client: 8081 total:   1879, 0:   1662, 1:     44, 2:     29, 4:     36, 8:     32, 16:     28, 32:      4, 64:      2, 128:     42
client: 8082 total:  17095, 0:  16579, 1:    153, 2:    120, 4:     93, 8:     78, 16:     52, 32:     14, 64:      3, 128:      3
client: 8083 total:   4241, 0:   4019, 1:     58, 2:     42, 4:     32, 8:     35, 16:      9, 32:      7, 64:      8, 128:     31
client: 8084 total:  16458, 0:  15833, 1:    188, 2:    159, 4:    133, 8:     97, 16:     33, 32:      8, 64:      3, 128:      4
client: 8085 total:  13510, 0:  12968, 1:    160, 2:    132, 4:    118, 8:     76, 16:     28, 32:     11, 64:      9, 128:      8
client: 8086 total:  18212, 0:  17715, 1:    139, 2:    124, 4:     93, 8:     77, 16:     41, 32:     15, 64:      7, 128:      1
client: 8087 total:    125, 0:     55, 1:      2, 2:      5, 4:      2, 8:      1, 16:      2, 32:      7, 64:      2, 128:     49
client: 8088 total:  15769, 0:  15230, 1:    139, 2:    144, 4:    120, 8:     72, 16:     43, 32:     14, 64:      3, 128:      4
client: 8089 total:  12778, 0:  12184, 1:    184, 2:    132, 4:    123, 8:     94, 16:     35, 32:     14, 64:      5, 128:      7
client: 8090 total:  18351, 0:  17817, 1:    170, 2:    105, 4:    113, 8:     84, 16:     39, 32:     20, 64:      2, 128:      1
client: 8091 total:  14935, 0:  14393, 1:    170, 2:    113, 4:    107, 8:     91, 16:     36, 32:     14, 64:      5, 128:      6
client: 8092 total:  18215, 0:  17610, 1:    195, 2:    136, 4:    132, 8:     88, 16:     41, 32:      8, 64:      4, 128:      1
client: 8093 total:  15437, 0:  14807, 1:    187, 2:    166, 4:    123, 8:     86, 16:     44, 32:     17, 64:      4, 128:      3
client: 8094 total:  18319, 0:  17758, 1:    170, 2:    129, 4:    118, 8:     91, 16:     40, 32:      7, 64:      3, 128:      3
client: 8095 total:  16463, 0:  15862, 1:    176, 2:    131, 4:    131, 8:     99, 16:     49, 32:      7, 64:      4, 128:      4
client: 8096 total:  17984, 0:  17393, 1:    188, 2:    128, 4:    126, 8:     82, 16:     51, 32:     14, 64:      2, 128:      0
client: 8097 total:  15794, 0:  15180, 1:    202, 2:    132, 4:    139, 8:     85, 16:     32, 32:     13, 64:      8, 128:      3
client: 8098 total:  16847, 0:  16297, 1:    163, 2:    122, 4:    125, 8:     77, 16:     41, 32:     19, 64:      1, 128:      2
client: 8099 total:  14232, 0:  13658, 1:    175, 2:    125, 4:    115, 8:     89, 16:     43, 32:     17, 64:      7, 128:      3
client: 8100 total:  11554, 0:  11213, 1:     95, 2:     77, 4:     48, 8:     60, 16:     30, 32:      9, 64:      3, 128:     19
client: 8101 total:  14600, 0:  13966, 1:    184, 2:    143, 4:    134, 8:     91, 16:     61, 32:     17, 64:      4, 128:      0
client: 8102 total:  17841, 0:  17247, 1:    175, 2:    124, 4:    124, 8:    105, 16:     57, 32:      7, 64:      1, 128:      1
client: 8103 total:  16135, 0:  15532, 1:    188, 2:    134, 4:    112, 8:     95, 16:     52, 32:     15, 64:      6, 128:      1
client: 8104 total:  18159, 0:  17600, 1:    155, 2:    146, 4:    119, 8:     83, 16:     42, 32:     11, 64:      2, 128:      1
client: 8105 total:  14533, 0:  13851, 1:    218, 2:    148, 4:    147, 8:    100, 16:     51, 32:     13, 64:      4, 128:      1
client: 8106 total:  18494, 0:  17959, 1:    173, 2:    129, 4:     98, 8:     75, 16:     43, 32:     11, 64:      3, 128:      3
client: 8107 total:  14925, 0:  14314, 1:    165, 2:    151, 4:    125, 8:     97, 16:     48, 32:     19, 64:      5, 128:      1
client: 8108 total:  16885, 0:  16302, 1:    150, 2:    146, 4:    143, 8:     88, 16:     40, 32:     11, 64:      4, 128:      1
client: 8109 total:  14011, 0:  13411, 1:    180, 2:    155, 4:    134, 8:     73, 16:     32, 32:     14, 64:      6, 128:      6
client: 8110 total:  16774, 0:  16227, 1:    174, 2:    120, 4:    104, 8:     80, 16:     47, 32:     16, 64:      4, 128:      2
client: 8111 total:  15467, 0:  14885, 1:    162, 2:    127, 4:    117, 8:    104, 16:     46, 32:     20, 64:      5, 128:      1
client: 8112 total:  17131, 0:  16595, 1:    180, 2:    114, 4:    113, 8:     67, 16:     38, 32:     17, 64:      4, 128:      3
client: 8113 total:  15269, 0:  14640, 1:    208, 2:    131, 4:    136, 8:     92, 16:     40, 32:     15, 64:      4, 128:      3
client: 8114 total:   9933, 0:   9575, 1:     92, 2:     85, 4:     74, 8:     44, 16:     27, 32:     10, 64:      4, 128:     22
client: 8115 total:   9741, 0:   9295, 1:    108, 2:    113, 4:     74, 8:     85, 16:     31, 32:     12, 64:      7, 128:     16
client: 8116 total:  16756, 0:  16206, 1:    162, 2:    142, 4:    125, 8:     72, 16:     26, 32:      9, 64:      9, 128:      5
client: 8117 total:    130, 0:     61, 1:      2, 2:      5, 4:      2, 8:      1, 16:      1, 32:      1, 64:      3, 128:     54
client: 8118 total:  17050, 0:  16494, 1:    174, 2:    132, 4:    106, 8:     89, 16:     34, 32:     14, 64:      7, 128:      0
client: 8119 total:  13867, 0:  13291, 1:    178, 2:    129, 4:    110, 8:     94, 16:     34, 32:     18, 64:      9, 128:      4
client: 8120 total:  17247, 0:  16684, 1:    174, 2:    148, 4:    103, 8:     87, 16:     34, 32:      8, 64:      3, 128:      6
client: 8121 total:  13990, 0:  13436, 1:    175, 2:    125, 4:    110, 8:     80, 16:     39, 32:     13, 64:      4, 128:      8
client: 8122 total:  17500, 0:  16948, 1:    181, 2:    130, 4:    109, 8:     67, 16:     43, 32:     16, 64:      2, 128:      4
client: 8123 total:  14558, 0:  13954, 1:    154, 2:    135, 4:    149, 8:     90, 16:     52, 32:     18, 64:      6, 128:      0
client: 8124 total:  18510, 0:  17944, 1:    162, 2:    154, 4:    110, 8:     79, 16:     46, 32:      8, 64:      7, 128:      0
client: 8125 total:  12900, 0:  12388, 1:    153, 2:    135, 4:    104, 8:     65, 16:     27, 32:     11, 64:      5, 128:     12
client: 8126 total:   6292, 0:   5908, 1:    102, 2:     96, 4:     73, 8:     50, 16:     26, 32:      5, 64:      4, 128:     28
client: 8127 total:   6170, 0:   5760, 1:    120, 2:     73, 4:     78, 8:     71, 16:     32, 32:     10, 64:      3, 128:     23

After
-----
client: 8000 total:  17468, 0:  16965, 1:    183, 2:    153, 4:     97, 8:     38, 16:      7, 32:      8, 64:      4, 128:     13
client: 8001 total:  17679, 0:  17277, 1:    106, 2:     89, 4:     92, 8:     69, 16:     23, 32:     15, 64:      4, 128:      4
client: 8002 total:  23029, 0:  22623, 1:    129, 2:     90, 4:     91, 8:     53, 16:     31, 32:      9, 64:      2, 128:      1
client: 8003 total:  22498, 0:  22067, 1:    135, 2:    127, 4:     90, 8:     48, 16:     20, 32:      5, 64:      4, 128:      2
client: 8004 total:  14136, 0:  13648, 1:    190, 2:    129, 4:     89, 8:     36, 16:     14, 32:      8, 64:      3, 128:     19
client: 8005 total:  18527, 0:  18098, 1:     92, 2:    112, 4:     97, 8:     79, 16:     28, 32:     16, 64:      4, 128:      1
client: 8006 total:   6436, 0:   6285, 1:     28, 2:     30, 4:     27, 8:     25, 16:      2, 32:      1, 64:      3, 128:     35
client: 8007 total:  12236, 0:  11980, 1:     72, 2:     53, 4:     59, 8:     36, 16:      4, 32:      4, 64:      4, 128:     24
client: 8008 total:  25641, 0:  25088, 1:    223, 2:    176, 4:     93, 8:     37, 16:     11, 32:      6, 64:      4, 128:      3
client: 8009 total:  19214, 0:  18735, 1:    155, 2:    108, 4:     86, 8:     91, 16:     23, 32:     10, 64:      4, 128:      2
client: 8010 total:  18909, 0:  18560, 1:     89, 2:     80, 4:     68, 8:     64, 16:     27, 32:     10, 64:      7, 128:      4
client: 8011 total:  22242, 0:  21834, 1:    100, 2:    119, 4:    104, 8:     48, 16:     22, 32:     12, 64:      3, 128:      0
client: 8012 total:    120, 0:     48, 1:      2, 2:      3, 4:      5, 8:      1, 16:      3, 32:      3, 64:      3, 128:     52
client: 8013 total:  19254, 0:  18809, 1:    121, 2:    110, 4:    103, 8:     73, 16:     20, 32:     11, 64:      3, 128:      4
client: 8014 total:    617, 0:    509, 1:      8, 2:     12, 4:      3, 8:     13, 16:     16, 32:      2, 64:      8, 128:     46
client: 8015 total:  22097, 0:  21625, 1:    155, 2:    117, 4:    112, 8:     51, 16:     25, 32:      8, 64:      4, 128:      0
client: 8016 total:  21352, 0:  20858, 1:    192, 2:    146, 4:     77, 8:     40, 16:     16, 32:     10, 64:      1, 128:     12
client: 8017 total:  18049, 0:  17589, 1:    125, 2:    103, 4:    112, 8:     64, 16:     35, 32:     16, 64:      5, 128:      0
client: 8018 total:  19155, 0:  18797, 1:     88, 2:     89, 4:     78, 8:     63, 16:     26, 32:      8, 64:      3, 128:      3
client: 8019 total:  22008, 0:  21534, 1:    135, 2:    117, 4:    122, 8:     72, 16:     19, 32:      7, 64:      1, 128:      1
client: 8020 total:  15444, 0:  15025, 1:    176, 2:    133, 4:     61, 8:     22, 16:      4, 32:      2, 64:      4, 128:     17
client: 8021 total:   9252, 0:   9028, 1:     58, 2:     47, 4:     41, 8:     21, 16:     15, 32:      5, 64:     14, 128:     23
client: 8022 total:  22300, 0:  21952, 1:     83, 2:     79, 4:    109, 8:     42, 16:     21, 32:      6, 64:      5, 128:      3
client: 8023 total:    134, 0:     61, 1:      2, 2:      2, 4:      2, 8:      1, 16:      6, 32:      4, 64:      5, 128:     51
client: 8024 total:  22997, 0:  22479, 1:    220, 2:    146, 4:     89, 8:     32, 16:     10, 32:      7, 64:      3, 128:     11
client: 8025 total:    140, 0:     73, 1:      2, 2:      3, 4:      0, 8:      0, 16:      1, 32:      3, 64:      5, 128:     53
client: 8026 total:  21543, 0:  21149, 1:    103, 2:     92, 4:    110, 8:     58, 16:     13, 32:     13, 64:      3, 128:      2
client: 8027 total:    347, 0:    256, 1:      9, 2:      3, 4:      6, 8:      7, 16:      7, 32:      5, 64:      4, 128:     50
client: 8028 total:  21340, 0:  20823, 1:    187, 2:    165, 4:     87, 8:     44, 16:     14, 32:      4, 64:      8, 128:      8
client: 8029 total:  18430, 0:  17933, 1:    153, 2:    138, 4:     88, 8:     70, 16:     29, 32:     13, 64:      3, 128:      3
client: 8030 total:  17339, 0:  17004, 1:     91, 2:     70, 4:     63, 8:     62, 16:     25, 32:     10, 64:      5, 128:      9
client: 8031 total:    679, 0:    586, 1:      3, 2:     10, 4:      4, 8:      5, 16:     11, 32:      8, 64:      4, 128:     48
client: 8032 total:  15330, 0:  14890, 1:    169, 2:    112, 4:     78, 8:     41, 16:     14, 32:      3, 64:      3, 128:     20
client: 8033 total:  18419, 0:  18044, 1:     89, 2:    100, 4:     86, 8:     61, 16:     21, 32:      7, 64:      3, 128:      8
client: 8034 total:  19947, 0:  19540, 1:    103, 2:     98, 4:     88, 8:     68, 16:     36, 32:     10, 64:      4, 128:      0
client: 8035 total:  22006, 0:  21573, 1:    130, 2:    122, 4:    103, 8:     50, 16:     14, 32:      9, 64:      2, 128:      3
client: 8036 total:  19452, 0:  18918, 1:    200, 2:    169, 4:     96, 8:     41, 16:      6, 32:      5, 64:      2, 128:     15
client: 8037 total:  19846, 0:  19371, 1:    129, 2:    137, 4:     99, 8:     68, 16:     30, 32:      8, 64:      1, 128:      3
client: 8038 total:  22000, 0:  21589, 1:    103, 2:     90, 4:    104, 8:     77, 16:     27, 32:      8, 64:      2, 128:      0
client: 8039 total:  20612, 0:  20176, 1:    137, 2:    112, 4:     88, 8:     59, 16:     26, 32:     10, 64:      3, 128:      1
client: 8040 total:  21084, 0:  20555, 1:    211, 2:    136, 4:    100, 8:     51, 16:     15, 32:      4, 64:      2, 128:     10
client: 8041 total:  11465, 0:  11106, 1:     82, 2:     72, 4:     88, 8:     60, 16:     24, 32:     15, 64:      9, 128:      9
client: 8042 total:  21455, 0:  21057, 1:    100, 2:     97, 4:    102, 8:     54, 16:     29, 32:     13, 64:      2, 128:      1
client: 8043 total:  22832, 0:  22389, 1:    118, 2:    133, 4:    106, 8:     51, 16:     23, 32:     10, 64:      2, 128:      0
client: 8044 total:  20445, 0:  19895, 1:    206, 2:    176, 4:     86, 8:     42, 16:     24, 32:      6, 64:      4, 128:      6
client: 8045 total:  19368, 0:  18880, 1:    139, 2:    118, 4:    127, 8:     56, 16:     31, 32:     13, 64:      4, 128:      0
client: 8046 total:  22747, 0:  22335, 1:    108, 2:     90, 4:    115, 8:     55, 16:     37, 32:      6, 64:      0, 128:      1
client: 8047 total:  24223, 0:  23816, 1:    110, 2:    110, 4:     97, 8:     61, 16:     23, 32:      4, 64:      1, 128:      1
client: 8048 total:  19573, 0:  19010, 1:    210, 2:    170, 4:     97, 8:     51, 16:     19, 32:      6, 64:      5, 128:      5
client: 8049 total:  19436, 0:  18974, 1:    111, 2:    123, 4:    107, 8:     77, 16:     27, 32:     15, 64:      1, 128:      1
client: 8050 total:  16210, 0:  15741, 1:    144, 2:    106, 4:     97, 8:     74, 16:     29, 32:     15, 64:      1, 128:      3
client: 8051 total:  19325, 0:  18876, 1:    150, 2:    105, 4:     97, 8:     61, 16:     22, 32:      7, 64:      2, 128:      5
client: 8052 total:  20278, 0:  19715, 1:    231, 2:    152, 4:    100, 8:     41, 16:     16, 32:     11, 64:      1, 128:     11
client: 8053 total:  19534, 0:  19084, 1:    103, 2:    125, 4:     97, 8:     83, 16:     27, 32:     10, 64:      3, 128:      2
client: 8054 total:  18630, 0:  18273, 1:    100, 2:     81, 4:     69, 8:     61, 16:     29, 32:      9, 64:      4, 128:      4
client: 8055 total:  22449, 0:  22046, 1:    104, 2:    112, 4:     94, 8:     59, 16:     24, 32:      6, 64:      0, 128:      4
client: 8056 total:  14745, 0:  14284, 1:    171, 2:    138, 4:     81, 8:     31, 16:     11, 32:     10, 64:      4, 128:     15
client: 8057 total:  18698, 0:  18243, 1:    127, 2:    103, 4:    109, 8:     64, 16:     38, 32:      8, 64:      5, 128:      1
client: 8058 total:  20386, 0:  19985, 1:     91, 2:    101, 4:     93, 8:     67, 16:     39, 32:      4, 64:      4, 128:      2
client: 8059 total:  16392, 0:  16050, 1:     93, 2:     90, 4:     81, 8:     29, 16:     25, 32:     12, 64:      3, 128:      9
client: 8060 total:  14156, 0:  13685, 1:    183, 2:    145, 4:     75, 8:     30, 16:      9, 32:      2, 64:      7, 128:     20
client: 8061 total:  15487, 0:  15090, 1:    100, 2:    101, 4:     85, 8:     57, 16:     29, 32:     10, 64:      4, 128:     11
client: 8062 total:  21870, 0:  21480, 1:     93, 2:     89, 4:     92, 8:     72, 16:     34, 32:      9, 64:      0, 128:      1
client: 8063 total:  21548, 0:  21108, 1:    114, 2:    123, 4:    114, 8:     54, 16:     24, 32:      7, 64:      3, 128:      1
client: 8064 total:  15865, 0:  15416, 1:    164, 2:    133, 4:     65, 8:     41, 16:     18, 32:      7, 64:      4, 128:     17
client: 8065 total:  19300, 0:  18846, 1:    139, 2:     97, 4:    103, 8:     67, 16:     29, 32:     15, 64:      3, 128:      1
client: 8066 total:  21636, 0:  21258, 1:     95, 2:     83, 4:     86, 8:     65, 16:     33, 32:     13, 64:      3, 128:      0
client: 8067 total:  22998, 0:  22534, 1:    142, 2:    139, 4:     97, 8:     53, 16:     25, 32:      5, 64:      3, 128:      0
client: 8068 total:  20846, 0:  20291, 1:    236, 2:    154, 4:     94, 8:     45, 16:      7, 32:      3, 64:      2, 128:     14
client: 8069 total:  18455, 0:  18041, 1:    117, 2:     93, 4:     89, 8:     68, 16:     35, 32:      5, 64:      4, 128:      3
client: 8070 total:  20788, 0:  20391, 1:    116, 2:     89, 4:     87, 8:     67, 16:     27, 32:      3, 64:      6, 128:      2
client: 8071 total:  21160, 0:  20752, 1:    114, 2:    107, 4:     91, 8:     57, 16:     24, 32:     11, 64:      4, 128:      0
client: 8072 total:  17179, 0:  16631, 1:    217, 2:    160, 4:     99, 8:     32, 16:     15, 32:      9, 64:      4, 128:     12
client: 8073 total:  19738, 0:  19279, 1:    123, 2:    105, 4:     98, 8:     81, 16:     37, 32:     13, 64:      2, 128:      0
client: 8074 total:  22019, 0:  21660, 1:     91, 2:     90, 4:     76, 8:     66, 16:     22, 32:      9, 64:      4, 128:      1
client: 8075 total:  21195, 0:  20723, 1:    142, 2:    122, 4:    114, 8:     58, 16:     23, 32:      9, 64:      4, 128:      0
client: 8076 total:  15700, 0:  15169, 1:    205, 2:    148, 4:    102, 8:     35, 16:     15, 32:      6, 64:      4, 128:     16
client: 8077 total:  19681, 0:  19214, 1:    116, 2:    122, 4:    106, 8:     70, 16:     42, 32:      7, 64:      4, 128:      0
client: 8078 total:  11631, 0:  11375, 1:     69, 2:     44, 4:     52, 8:     39, 16:     21, 32:      2, 64:      2, 128:     27
client: 8079 total:  20008, 0:  19660, 1:     82, 2:     87, 4:     93, 8:     44, 16:     28, 32:      7, 64:      2, 128:      5
client: 8080 total:  20259, 0:  19726, 1:    218, 2:    159, 4:     91, 8:     34, 16:     11, 32:      3, 64:      2, 128:     15
client: 8081 total:  19811, 0:  19324, 1:    122, 2:    114, 4:    127, 8:     85, 16:     23, 32:     10, 64:      5, 128:      1
client: 8082 total:  21245, 0:  20822, 1:    121, 2:     92, 4:     98, 8:     67, 16:     34, 32:      9, 64:      1, 128:      1
client: 8083 total:  21712, 0:  21300, 1:    109, 2:    117, 4:     90, 8:     63, 16:     20, 32:      7, 64:      6, 128:      0
client: 8084 total:   8961, 0:   8720, 1:     49, 2:     63, 4:     41, 8:     35, 16:     13, 32:      9, 64:      2, 128:     29
client: 8085 total:  16346, 0:  15931, 1:     98, 2:    118, 4:     89, 8:     57, 16:     25, 32:     19, 64:      4, 128:      5
client: 8086 total:  22391, 0:  22036, 1:     83, 2:     80, 4:     78, 8:     76, 16:     23, 32:     13, 64:      2, 128:      0
client: 8087 total:  22899, 0:  22496, 1:    115, 2:    102, 4:     93, 8:     54, 16:     26, 32:     12, 64:      1, 128:      0
client: 8088 total:  10856, 0:  10436, 1:    136, 2:    117, 4:     79, 8:     36, 16:     18, 32:      8, 64:      7, 128:     19
client: 8089 total:  15974, 0:  15631, 1:     79, 2:     86, 4:     71, 8:     62, 16:     22, 32:      8, 64:      5, 128:     10
client: 8090 total:  13596, 0:  13301, 1:     73, 2:     70, 4:     55, 8:     47, 16:     21, 32:      7, 64:      6, 128:     16
client: 8091 total:  23783, 0:  23384, 1:     98, 2:    105, 4:    104, 8:     62, 16:     21, 32:      7, 64:      1, 128:      1
client: 8092 total:  20799, 0:  20261, 1:    205, 2:    167, 4:    102, 8:     37, 16:     11, 32:      0, 64:      5, 128:     11
client: 8093 total:  18659, 0:  18257, 1:    100, 2:     83, 4:     91, 8:     63, 16:     45, 32:     16, 64:      2, 128:      2
client: 8094 total:  21400, 0:  21008, 1:    103, 2:     87, 4:     98, 8:     54, 16:     37, 32:     12, 64:      1, 128:      0
client: 8095 total:  15427, 0:  15079, 1:     93, 2:     94, 4:     74, 8:     45, 16:     21, 32:      7, 64:      2, 128:     12
client: 8096 total:  17711, 0:  17137, 1:    228, 2:    166, 4:    100, 8:     35, 16:     23, 32:      6, 64:      4, 128:     12
client: 8097 total:  19350, 0:  18853, 1:    168, 2:    106, 4:     97, 8:     78, 16:     33, 32:     12, 64:      3, 128:      0
client: 8098 total:  23316, 0:  22909, 1:    108, 2:     95, 4:     85, 8:     72, 16:     41, 32:      5, 64:      1, 128:      0
client: 8099 total:  19561, 0:  19178, 1:     95, 2:    111, 4:     90, 8:     45, 16:     28, 32:      8, 64:      2, 128:      4
client: 8100 total:  17246, 0:  16819, 1:    141, 2:    129, 4:     85, 8:     35, 16:      7, 32:      6, 64:      5, 128:     19
client: 8101 total:  18356, 0:  17890, 1:    127, 2:    121, 4:     95, 8:     72, 16:     34, 32:     11, 64:      4, 128:      2
client: 8102 total:  20836, 0:  20469, 1:     97, 2:     86, 4:     89, 8:     59, 16:     21, 32:      8, 64:      5, 128:      2
client: 8103 total:  24089, 0:  23695, 1:    102, 2:    103, 4:    111, 8:     47, 16:     20, 32:     10, 64:      1, 128:      0
client: 8104 total:  15747, 0:  15241, 1:    222, 2:    141, 4:     74, 8:     32, 16:     10, 32:      6, 64:      5, 128:     16
client: 8105 total:  17002, 0:  16535, 1:    168, 2:    111, 4:     77, 8:     65, 16:     22, 32:     14, 64:      6, 128:      4
client: 8106 total:  22628, 0:  22240, 1:    106, 2:     82, 4:     88, 8:     69, 16:     32, 32:     10, 64:      1, 128:      0
client: 8107 total:  22023, 0:  21626, 1:    100, 2:    114, 4:     93, 8:     60, 16:     19, 32:      5, 64:      4, 128:      2
client: 8108 total:  18144, 0:  17629, 1:    190, 2:    163, 4:     92, 8:     40, 16:      8, 32:      3, 64:      4, 128:     15
client: 8109 total:  17561, 0:  17154, 1:    107, 2:     95, 4:     83, 8:     68, 16:     36, 32:      8, 64:      5, 128:      5
client: 8110 total:  22314, 0:  21910, 1:     95, 2:     93, 4:     98, 8:     73, 16:     38, 32:      5, 64:      2, 128:      0
client: 8111 total:  22880, 0:  22425, 1:    134, 2:    126, 4:    110, 8:     51, 16:     23, 32:      8, 64:      2, 128:      1
client: 8112 total:  12952, 0:  12537, 1:    137, 2:    124, 4:     75, 8:     41, 16:      9, 32:      2, 64:      3, 128:     24
client: 8113 total:  16787, 0:  16351, 1:    110, 2:    104, 4:     95, 8:     72, 16:     32, 32:     14, 64:      4, 128:      5
client: 8114 total:  20322, 0:  19945, 1:    104, 2:     88, 4:     76, 8:     58, 16:     36, 32:     10, 64:      3, 128:      2
client: 8115 total:  22593, 0:  22202, 1:    102, 2:    105, 4:    104, 8:     43, 16:     27, 32:      7, 64:      0, 128:      3
client: 8116 total:  20900, 0:  20358, 1:    213, 2:    147, 4:     99, 8:     48, 16:     15, 32:      5, 64:      6, 128:      9
client: 8117 total:  14035, 0:  13670, 1:     82, 2:     83, 4:     89, 8:     52, 16:     28, 32:     15, 64:      2, 128:     14
client: 8118 total:  20964, 0:  20596, 1:    106, 2:     87, 4:     69, 8:     59, 16:     31, 32:     12, 64:      3, 128:      1
client: 8119 total:  23436, 0:  23014, 1:    108, 2:    108, 4:    118, 8:     55, 16:     23, 32:      8, 64:      2, 128:      0
client: 8120 total:  24200, 0:  23686, 1:    186, 2:    163, 4:     91, 8:     40, 16:     14, 32:      9, 64:      5, 128:      6
client: 8121 total:  17591, 0:  17102, 1:    123, 2:    132, 4:    100, 8:     82, 16:     35, 32:     10, 64:      6, 128:      1
client: 8122 total:  23257, 0:  22843, 1:     94, 2:    103, 4:    110, 8:     72, 16:     26, 32:      7, 64:      2, 128:      0
client: 8123 total:  23511, 0:  23087, 1:    120, 2:    126, 4:     96, 8:     48, 16:     24, 32:      6, 64:      4, 128:      0
client: 8124 total:  19985, 0:  19447, 1:    210, 2:    153, 4:    103, 8:     42, 16:      8, 32:      6, 64:      5, 128:     11
client: 8125 total:  18987, 0:  18497, 1:    145, 2:    101, 4:     99, 8:     98, 16:     29, 32:     16, 64:      2, 128:      0
client: 8126 total:  20228, 0:  19836, 1:     95, 2:     90, 4:     86, 8:     79, 16:     28, 32:      9, 64:      4, 128:      1
client: 8127 total:  22328, 0:  21935, 1:    100, 2:    111, 4:     94, 8:     54, 16:     21, 32:      8, 64:      4, 128:      1

-- 
Best regards,
Ridong


