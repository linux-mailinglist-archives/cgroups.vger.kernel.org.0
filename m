Return-Path: <cgroups+bounces-6235-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAB7A1585E
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 20:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CA93A989D
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 19:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F44D1A841B;
	Fri, 17 Jan 2025 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qrc01R0O"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7914B1A4E98
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737143507; cv=none; b=KyRzwg5QndI2OjmxRuEJlHNZUidTVs6O2pebFvRs6+1QYaDciTtAeZIdB+9M90j53Rmrs/KBEQkI1BfzH5iV/M/vUh10r/hXR73jJuJp9ZWpptbR2Ruw5TC8IZiwn8/k4driKGx3/TW0M3Nq9bCNRrQDJJTJtPH87dBo1MXYYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737143507; c=relaxed/simple;
	bh=cqOu65gr+DaZgExus54LrhwixoubpIXd8fHdd0pNZdA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n99JJJgL/Mq6JNS8ihqQcnEAbZw94aR7FyzCuwKn2VPSp4Gw/qJZiOkdmXvkBlTu8HIgy09hqyFPoWu+SNp+I2vqrjX7G54zcNLAwpCzvdqW83h5x4f11QxcWFcwT6uJaWzpJytE84v/zbClgydFo7rAn3GEjeETpq3K7ll9VAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qrc01R0O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737143504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QnyLnGRtVQN2q1mNgotdRICNU0nfvlNZ9SAirRUqpu8=;
	b=Qrc01R0OXdcGqsu7V2DfHr0JWXmf38CrOoZrDpOnOg4cybp24UnvYMilS+WNd+a+jdZrLA
	nto42CzPuWJ8ISrsRAvYyvRwDPfOHqTEH7yregtpA0EkNLgH+g5Gnfs9edZ1ew5w/XQzTe
	mTT2DZWYSoW8MOcqJXNSMosaPkh048o=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-BwWzVAZBNHyHylPPNoWLqQ-1; Fri, 17 Jan 2025 14:51:40 -0500
X-MC-Unique: BwWzVAZBNHyHylPPNoWLqQ-1
X-Mimecast-MFC-AGG-ID: BwWzVAZBNHyHylPPNoWLqQ
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8f14fc179so78203356d6.2
        for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 11:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737143500; x=1737748300;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnyLnGRtVQN2q1mNgotdRICNU0nfvlNZ9SAirRUqpu8=;
        b=NQ8QuMx7woaPlTDzKqv2R7QlfAbHjWzfjTfq50K8Mt6EaCWt2gZmI0aVzD9R5ZTzWk
         mT9LiPoTdAFPckrT7M2pRp40kcSJhh7uR5jgD71y02xbSGM0yW2iueiLscMnTaIeiRh7
         Bp2isGkyPruVUGZ0KXAvyEm4rtwU4yAPG0TxT3EmPtmmbFl5r6M/jjguJMejN7M3XJU/
         Tr7BLHSkk0QG+QzKAth/DZAYRIAwMBLW6see9nmXv1XLSq871oN2UeIkiPzfVz+YwB3L
         71yDKbkjrVGLlAsd69gD07dDq4IXNUTJeaCZRqpcOcsn4GECwb/vujT+AsSlkbNlwseA
         7HkA==
X-Forwarded-Encrypted: i=1; AJvYcCVFg5ADBlf088gyWBZuqvmg2nXAyFUgtm7LaeyaJM6bA6rs+pYvAhElN6inbzhPhvEgRVTeCwcp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Y5vjBpuGs5SqtjethJsnx4B1yxT60+xSORMbvllxurgo1FRg
	bjSyn1mY4oxpAUTP3IiFG8G/GyLLHIucxzSFOq4Sg9a13FZAyLtyAAyn+ciRgg24pGNrAmC8Tbq
	vGsFeUKElTZtsIjtMOtGOZynDf7/8AfbLo/EgYqdu9KYnayF9bB+bIOA=
X-Gm-Gg: ASbGnctz1kE0xoregsdkhTSgeyMiC+FmSDiBeFzISmkPb8K16OXv0w66MxDeTxyPM2P
	FNWQqjitOLB3xk0H8DJBDatccAHn5mTNgCfwF+wLCZ645HZzYTKFsZJXrxBaKmfrJeGHDhBUUG4
	71SOdy1vceFeLuPx2UdHFVPCP46pcgQhRlWhHzPYkzTR7ZpklaDVuEoZxAuHgfjOl33msNv5lgd
	jtaDh9fUG2XH1rDUb/RFAeoZSVKO+f66aJNNzIOH23cwMZ6dmAgrJCC+LH3FnPFamKzembyzCIn
	Oo2ef0TM9uOz/IyaNrTY9OjluCk=
X-Received: by 2002:a05:6214:29e3:b0:6d8:9838:d3a9 with SMTP id 6a1803df08f44-6e1b21c72f7mr54482566d6.26.1737143500394;
        Fri, 17 Jan 2025 11:51:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmgTKoDNg+mdRqxXapTpIigI8ztamLxf/H4UZA73IYIA2oKFLE/IE2jLXWZEeJM/Bkj5jLmg==
X-Received: by 2002:a05:6214:29e3:b0:6d8:9838:d3a9 with SMTP id 6a1803df08f44-6e1b21c72f7mr54482296d6.26.1737143500094;
        Fri, 17 Jan 2025 11:51:40 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afce3967sm14726306d6.99.2025.01.17.11.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 11:51:39 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4ea9fbd6-dc6d-499e-9110-461ed0462309@redhat.com>
Date: Fri, 17 Jan 2025 14:51:38 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tj-cgroup:for-next 5/5] kernel/cgroup/cpuset-v1.c:397:18: error:
 implicit declaration of function 'cgroup_path_ns_locked'; did you mean
 'cgroup_path_ns'?
To: kernel test robot <lkp@intel.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
 Tejun Heo <tj@kernel.org>
References: <202501180315.KcDn5BG5-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202501180315.KcDn5BG5-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/17/25 2:45 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
> head:   03a12b026323247a320495fed3719d39cffdbe9b
> commit: 03a12b026323247a320495fed3719d39cffdbe9b [5/5] cgroup/cpuset: Move procfs cpuset attribute under cgroup-v1.c
> config: x86_64-buildonly-randconfig-006-20250118 (https://download.01.org/0day-ci/archive/20250118/202501180315.KcDn5BG5-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250118/202501180315.KcDn5BG5-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501180315.KcDn5BG5-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     kernel/cgroup/cpuset-v1.c: In function 'proc_cpuset_show':
>>> kernel/cgroup/cpuset-v1.c:397:18: error: implicit declaration of function 'cgroup_path_ns_locked'; did you mean 'cgroup_path_ns'? [-Werror=implicit-function-declaration]
>       397 |         retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
>           |                  ^~~~~~~~~~~~~~~~~~~~~
>           |                  cgroup_path_ns
>     cc1: some warnings being treated as errors
>
>
> vim +397 kernel/cgroup/cpuset-v1.c
>
>     375	
>     376	#ifdef CONFIG_PROC_PID_CPUSET
>     377	/*
>     378	 * proc_cpuset_show()
>     379	 *  - Print tasks cpuset path into seq_file.
>     380	 *  - Used for /proc/<pid>/cpuset.
>     381	 */
>     382	int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
>     383			     struct pid *pid, struct task_struct *tsk)
>     384	{
>     385		char *buf;
>     386		struct cgroup_subsys_state *css;
>     387		int retval;
>     388	
>     389		retval = -ENOMEM;
>     390		buf = kmalloc(PATH_MAX, GFP_KERNEL);
>     391		if (!buf)
>     392			goto out;
>     393	
>     394		rcu_read_lock();
>     395		spin_lock_irq(&css_set_lock);
>     396		css = task_css(tsk, cpuset_cgrp_id);
>   > 397		retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
>     398					       current->nsproxy->cgroup_ns);
>     399		spin_unlock_irq(&css_set_lock);
>     400		rcu_read_unlock();
>     401	
>     402		if (retval == -E2BIG)
>     403			retval = -ENAMETOOLONG;
>     404		if (retval < 0)
>     405			goto out_free;
>     406		seq_puts(m, buf);
>     407		seq_putc(m, '\n');
>     408		retval = 0;
>     409	out_free:
>     410		kfree(buf);
>     411	out:
>     412		return retval;
>     413	}
>     414	#endif /* CONFIG_PROC_PID_CPUSET */
>     415	
>
Now cpuset-v1.c needs to include "cgroup-internal.h".

Cheers,
Longman


