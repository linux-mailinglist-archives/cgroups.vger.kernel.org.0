Return-Path: <cgroups+bounces-8312-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A13AC0BB0
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 14:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EC53B4416
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1134E28A708;
	Thu, 22 May 2025 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wk3m2a+6"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103A22FF2B;
	Thu, 22 May 2025 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747917461; cv=none; b=ogvLWxyrlH1qDWA7LtWfmuyCAvtg863/tWLpZ/XkWf0zcItJy26XpWL9ua+KRDzg5erYFQTtPRqyJ9mCdSuhW99Z7KMl0ckk5q9qQPwJ+s85NcVdA0HTi8Fdwh0DnU0SYxLTBSHfSKt1A7PhKo5K6MPknE0mKEOTOade83CjApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747917461; c=relaxed/simple;
	bh=7BHIIAUVoOOy0N4+Qaw/456HNKKlG2GRqhkQvFpYOyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bs4UySUkJfa9yRS9DXwll4bCSBbWKiyDkv2VzNf795JZhPARWrWiIogPPRrfQc4ZK4xDFGTZukUBOhVntVqHZANBHbOy1anW1pTAWphRzKkg4ZSDB/8G8xYm3E5ZRaJNAk3PHLo6cOyRb7hm9I7iBR+0zcoNSfFsuEKwI7rotjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wk3m2a+6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M8FCLc006470;
	Thu, 22 May 2025 12:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jNmUnM
	pfYdIVeP+Jb/MjUheQzeyhvoVC0wrvPkXFrVg=; b=Wk3m2a+6lODOpA39vwyvOz
	Ys5GwZSKCcbeRyCNNQHBb57aZ7gwUm/g0wbLmR0GfLctdOLeMDWO54WVJtJzMU3I
	ieHNO1NGpUpGd16M1e4c6Vhy2x00MWm22Fk0IaHzzmW+wFs+ximHhW1V6TNWhmZK
	LFTChsnbMhBZbtO/wj3sFP6sYkQHRC94pui2oODCFYo94iqYlmGAhK6FVDlqyES6
	KWwYjC/6ph8POBCiR7UyoqJLkKb1FMLqmB6096kDj5MtTc6aMmuMr2dHLeIXG/fz
	ZG/hKUM1kjfidOsioI5O0nVmMKLzngwO5nV5pN0iECOYwI+j1tz9doTUU+Sh/8IQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sg235nhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 12:37:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54M9VSRW020693;
	Thu, 22 May 2025 12:37:27 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwkq1eac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 12:37:27 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54MCbMo624511052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 12:37:22 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01A3C58060;
	Thu, 22 May 2025 12:37:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED9E558059;
	Thu, 22 May 2025 12:37:22 +0000 (GMT)
Received: from [9.109.198.223] (unknown [9.109.198.223])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 May 2025 12:37:22 +0000 (GMT)
Message-ID: <95753732-9714-42e0-8097-e2b4c3dd5820@linux.ibm.com>
Date: Thu, 22 May 2025 18:07:21 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [block] 245618f8e4: stress-ng.fpunch.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
References: <202505221030.760980df-lkp@intel.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <202505221030.760980df-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0BYIBvohkylXjmXVMkU7fnvyw0P-MZXz
X-Authority-Analysis: v=2.4 cv=RPmzH5i+ c=1 sm=1 tr=0 ts=682f1a87 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=i3X5FwGiAAAA:8 a=shPPcO8FRoZR3bCwaZgA:9
 a=QEXdDO2ut3YA:10 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDEyOCBTYWx0ZWRfX7vQ1DvbqR7mX Ro6LhcUCd/NpssiUqx4AmVrXpkevmdxYZAfljNXdWhuqYV5ThTWkxKqn12NUe7wawgqMisVWeNC dob6oEuzX0RJbvmPLi24eFK9fTGSkkbnlOpKguNv3MLkDug4w1c62YA578F2cwASbWq/mZyZk/q
 lSFtmDwc1LwxHnH/sHPoxyBcPFBO45tX8AuW7SBePFeOgnqJhbqH0hcN6jZGB3PpLnj2FMh9KBJ /bmCQyYQXhYHWDQW8hI18dJQUWJ6j7VYZ1zGOBnf/9lYgbuanNtGoWbkQlT3Ct/2tRDsN3Uwv36 oHTy+5COnmkyrMRazEQrj+4OmeFXLQDHwd7C0SyS5FXtomlhbXkyx1jZX684DvSl/mvo5EqdWXA
 ipm6YnTlN6/8E/emBS/BW8O13DPHdhcBEtonBNflDl6rPmTDLKlEsm2BTS5kkmIYngv7iuQZ
X-Proofpoint-GUID: 0BYIBvohkylXjmXVMkU7fnvyw0P-MZXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220128



On 5/22/25 7:59 AM, kernel test robot wrote:
> 
> 
> Hello,
> 
> 
> we don't have enough knowledge if this is a kernel issue or test case issue.
> 
> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/disk/testtime/fs/test/cpufreq_governor:
>   lkp-icl-2sp4/stress-ng/debian-12-x86_64-20240206.cgz/x86_64-rhel-9.4/gcc-12/100%/1HDD/60s/xfs/fpunch/performance
> 
> 3efe7571c3ae2b64 245618f8e45ff4f79327627b474
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6          100%           6:6     stress-ng.fpunch.fail
> 
> since the failure is persistent, just report what we observed in our tests FYI.
> 
> 
> kernel test robot noticed "stress-ng.fpunch.fail" on:
> 
> commit: 245618f8e45ff4f79327627b474b563da71c2c75 ("block: protect wbt_lat_usec using q->elevator_lock")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      b36ddb9210e6812eb1c86ad46b66cc46aa193487]
> [test failed on linux-next/master 8566fc3b96539e3235909d6bdda198e1282beaed]
> [test failed on fix commit        9730763f4756e32520cb86778331465e8d063a8f]
> 
> in testcase: stress-ng
> version: stress-ng-x86_64-1c71921fd-1_20250212
> with following parameters:
> 
> 	nr_threads: 100%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: xfs
> 	test: fpunch
> 	cpufreq_governor: performance
> 
> 
> 
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202505221030.760980df-lkp@intel.com
> 
> 2025-03-20 08:33:52 mkdir -p /mnt/stress-ng
> 2025-03-20 08:33:52 mount /dev/sdc1 /mnt/stress-ng
> 2025-03-20 08:33:52 cd /mnt/stress-ng
>   File: "/mnt/stress-ng"
>     ID: 82100000000 Namelen: 255     Type: xfs
> Block size: 4096       Fundamental block size: 4096
> Blocks: Total: 78604800   Free: 78518242   Available: 78518242
> Inodes: Total: 157286400  Free: 157286397
> 2025-03-20 08:33:52 stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --fpunch 128
> stress-ng: info:  [4680] setting to a 1 min run per stressor
> stress-ng: info:  [4680] dispatching hogs: 128 fpunch
> stress-ng: info:  [4680] note: /proc/sys/kernel/sched_autogroup_enabled is 1 and this can impact scheduling throughput for processes not attached to a tty. Setting this to 0 may improve performance metrics
> stress-ng: warn:  [4680] metrics-check: all bogo-op counters are zero, data may be incorrect
> stress-ng: metrc: [4680] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
> stress-ng: metrc: [4680]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
> stress-ng: metrc: [4680] fpunch                0    557.92      0.40     19.56         0.00           0.00         0.03          3180
> stress-ng: metrc: [4680] miscellaneous metrics:
> stress-ng: metrc: [4680] fpunch              2049.12 extents per file (geometric mean of 128 instances)
> stress-ng: info:  [4680] for a 620.45s run time:
> stress-ng: info:  [4680]   79418.05s available CPU time
> stress-ng: info:  [4680]       0.40s user time   (  0.00%)
> stress-ng: info:  [4680]      19.59s system time (  0.02%)
> stress-ng: info:  [4680]      19.99s total time  (  0.03%)
> stress-ng: info:  [4680] load average: 250.69 349.62 213.80
> stress-ng: info:  [4680] skipped: 0
> stress-ng: info:  [4680] passed: 128: fpunch (128)
> stress-ng: info:  [4680] failed: 0
> stress-ng: info:  [4680] metrics untrustworthy: 0
> stress-ng: info:  [4680] successful run completed in 10 mins, 20.45 secs
> 
> 
> we don't observe any abnormal output in dmesg. below is an example from parent
> commit.
> 
> 2025-03-20 09:12:39 mkdir -p /mnt/stress-ng
> 2025-03-20 09:12:39 mount /dev/sdc1 /mnt/stress-ng
> 2025-03-20 09:12:39 cd /mnt/stress-ng
>   File: "/mnt/stress-ng"
>     ID: 82100000000 Namelen: 255     Type: xfs
> Block size: 4096       Fundamental block size: 4096
> Blocks: Total: 78604800   Free: 78518242   Available: 78518242
> Inodes: Total: 157286400  Free: 157286397
> 2025-03-20 09:12:39 stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --fpunch 128
> stress-ng: info:  [4689] setting to a 1 min run per stressor
> stress-ng: info:  [4689] dispatching hogs: 128 fpunch
> stress-ng: info:  [4689] note: /proc/sys/kernel/sched_autogroup_enabled is 1 and this can impact scheduling throughput for processes not attached to a tty. Setting this to 0 may improve performance metrics
> stress-ng: metrc: [4689] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
> stress-ng: metrc: [4689]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
> stress-ng: metrc: [4689] fpunch             1166     60.31      0.11     34.66        19.33          33.54         0.45          3164
> stress-ng: metrc: [4689] miscellaneous metrics:
> stress-ng: metrc: [4689] fpunch              2051.97 extents per file (geometric mean of 128 instances)
> stress-ng: info:  [4689] for a 60.91s run time:
> stress-ng: info:  [4689]    7796.93s available CPU time
> stress-ng: info:  [4689]       0.11s user time   (  0.00%)
> stress-ng: info:  [4689]      34.68s system time (  0.44%)
> stress-ng: info:  [4689]      34.79s total time  (  0.45%)
> stress-ng: info:  [4689] load average: 325.78 93.83 32.28
> stress-ng: info:  [4689] skipped: 0
> stress-ng: info:  [4689] passed: 128: fpunch (128)
> stress-ng: info:  [4689] failed: 0
> stress-ng: info:  [4689] metrics untrustworthy: 0
> stress-ng: info:  [4689] successful run completed in 1 min
> 
> 
> from above, parent can finish run in 1 min, then has "bogo ops" and "bogo ops/s"
> 
> for 245618f8e4, the test seems run much longer, and the results for "bogo ops"
> and "bogo ops/s" are all 0.
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250522/202505221030.760980df-lkp@intel.com
> 

I tried reproducing this issue but I couldn't recreate it. Is it possible
for you to run this test on your setup using stress-ng option "--iostat 1"
as shown below ?

# stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --fpunch 128 --iostat 1

If you can run test with above option then please collect logs and share it.
That might help to further debug this.

Thanks,
--Nilay


