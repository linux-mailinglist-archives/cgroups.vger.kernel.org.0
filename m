Return-Path: <cgroups+bounces-6800-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF13A4D5C3
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 09:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4051885ACB
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 08:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04BF1F91F4;
	Tue,  4 Mar 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kmPLqm8Z"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D771F8F09;
	Tue,  4 Mar 2025 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075637; cv=none; b=J5m9Pb8QzpCbA3ejJUwskZLsQhILfTCx6d8bdv21qn5Sk81lcwEMBNTLv5oCVq2GYOH+4RM+P9Y+WfMqIDIzBGoNR0BaDiuznd5z12G4feEDN6LZOcedR0st0WFv6dFx2zL8M47zytM+FJxc8TAGJFMjAWitdYdJLijP85V5hJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075637; c=relaxed/simple;
	bh=6aNL42DWMh9CZ3QEsxgfMG8yL5+ldkOJylZSLJdAIyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnrV4PnwbZ/gG0cq3s/tj3JCaGVXxV5NEaz4Sjv6NyYQ41AT0GwKzObLjQJulId4gFzOj0ZW1O2JkSP9iUAoPXpvAjq/03fRgBfMHL/Df5ecZZchGJUL/iVEufKRXl80d6mgTfaVCb+FFfSwathfkwQDRUxr/C6I15ZMLSuKuc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kmPLqm8Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5243jibx021554;
	Tue, 4 Mar 2025 08:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w+t+MF
	rkX0h/lUj1N1OvUCVfE0zwgyCqmUjX5NAs+KM=; b=kmPLqm8ZDuZ8bKlHwJ1cn5
	GVrGvxjORKFbrlTxU7qe/UYm2avimVDI6ZHM638/DCAOM+LQKWNQXbxnf7Vc/dyZ
	vFxxY79a2i0fVHgNSS8IW024f7/TpFI9fBgd9nUnD3JTWlJcFvWNhH3UI6MsC/+p
	L7XQPVj1cZOC9L204UtQCvVds2A9dW1qb0upD127LAMYphwS6+ns5AQCAT66+4uo
	090QKLoHaFTPRQDa90DUqKZqmMTe4Cc4EH230arhF7fyX8diTtoPdc5lx19MXafa
	M0uKLnkv2yM67wEgWOJlGevlExosdaYLMdVhglboc7/I62XmS5WP8ZxjpqSAil8w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455sw7h4fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:07:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5247kPIt020841;
	Tue, 4 Mar 2025 08:06:59 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnccgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:06:59 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52486xfH30999050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 08:06:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0882258065;
	Tue,  4 Mar 2025 08:06:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 566AE58059;
	Tue,  4 Mar 2025 08:06:55 +0000 (GMT)
Received: from [9.109.198.149] (unknown [9.109.198.149])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 08:06:54 +0000 (GMT)
Message-ID: <0d440eb5-93f5-4f6c-a3a6-c255e73d9e56@linux.ibm.com>
Date: Tue, 4 Mar 2025 13:36:53 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 6/7] block: protect wbt_lat_usec using q->elevator_lock
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Hannes Reinecke <hare@suse.de>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org, hch@lst.de,
        ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
References: <202503041413.872983bd-lkp@intel.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <202503041413.872983bd-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5O2U86l-RoKFikCMpyKAu600onfJjz8W
X-Proofpoint-GUID: 5O2U86l-RoKFikCMpyKAu600onfJjz8W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_04,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040067



On 3/4/25 11:48 AM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "sysfs:cannot_create_duplicate_filename" on:
> 
> commit: 2951441c42530952368c2bae7190ea8779b2385f ("[PATCHv5 6/7] block: protect wbt_lat_usec using q->elevator_lock")
> url: https://github.com/intel-lab-lkp/linux/commits/Nilay-Shroff/block-acquire-q-limits_lock-while-reading-sysfs-attributes/20250226-204836
> base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
> patch link: https://lore.kernel.org/all/20250226124006.1593985-7-nilay@linux.ibm.com/
> patch subject: [PATCHv5 6/7] block: protect wbt_lat_usec using q->elevator_lock
> 
> in testcase: boot
> 
> config: x86_64-randconfig-074-20250228
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +----------------------------------------+------------+------------+
> |                                        | 96ec4f2440 | 2951441c42 |
> +----------------------------------------+------------+------------+
> | sysfs:cannot_create_duplicate_filename | 0          | 12         |
> +----------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202503041413.872983bd-lkp@intel.com
> 
> 
> [   14.648633][    T1] Non-volatile memory driver v1.3
> [   14.649743][    T1] telclk_interrupt = 0xf non-mcpbl0010 hw.
> [   14.650659][    T1] usbcore: registered new interface driver xillyusb
> [   14.658940][    T1] zram: Added device: zram0
> [   14.659758][   T11] Floppy drive(s): fd0 is 2.88M AMI BIOS
> [   14.662273][    T1] sysfs: cannot create duplicate filename '/devices/virtual/block/nullb0/queue/wbt_lat_usec'
> [   14.663506][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.14.0-rc3-00270-g2951441c4253 #1 adcfde6e4f1dd47f52d455fb462243a4f271be2a
> [   14.664847][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   14.665952][    T1] Call Trace:
> [   14.666355][    T1]  <TASK>
> [ 14.666473][ T1] dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:123 (discriminator 1)) 
> [ 14.666473][ T1] dump_stack (kbuild/src/consumer/lib/dump_stack.c:130) 
> [ 14.666473][ T1] sysfs_warn_dup (kbuild/src/consumer/fs/sysfs/dir.c:32) 
> [ 14.666473][ T1] sysfs_add_file_mode_ns (kbuild/src/consumer/fs/sysfs/file.c:318) 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250304/202503041413.872983bd-lkp@intel.com
> 
Sorry, but there was a stale entry left over for wbt_lat_usec attribute 
causing the observed symptom.I will be sending next patchset with the fix.

Thanks,
--Nilay
 

