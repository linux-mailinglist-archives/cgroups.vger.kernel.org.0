Return-Path: <cgroups+bounces-5605-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CC09D0B6C
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 10:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F941F22365
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 09:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0905E1885BF;
	Mon, 18 Nov 2024 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dr46EKwS"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B307D153836
	for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921072; cv=none; b=sfB9wcPv57tDnhoJyhgdc3xVktZP0CtkNWwrl74kDheqofHPOBQWukDknxZnl7ADTuNyklSsEVCq/Hjk7Y+UX0ZXmc7eiZqEVW6EFkqExdTnv4o9vn7QQdVkaTOYiTDzCzauFnJUbGjgQ30zBmcbC7EeHm3sld7tKyX/S4QCw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921072; c=relaxed/simple;
	bh=DwR7VXUazf58wWSPiH9dmeN+GYZK9jzN2V6DznCGx6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKy+iiKWaq/UT4wsGWc5fIna5Qoru+Hcs7O/zQ6zvl5nEyMYHKutI7Ew6hLeKioSwlAXyzo8I7aoDVeJtGRydDUm6dHsVjmDNaRii2FTiXtNANnc5A+P9PEwQlkAXwxtxAO9n5TlByDQ1sfMzLfJPR4Q0+khrGzALFhZcEoQBVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dr46EKwS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731921069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zaPvO86EJKOHufTcTTk7TOivaHoUoSkP3MPU2pK0O34=;
	b=dr46EKwSEVsBIJtN5mPfsxNXq7eLLBVx8KtMJD/4mJvhPOQY0qVQZnHUOv03SsMQuVyZO6
	vb7bn8/8v2UNeMPmc2cXw9/4AcGKvj2JbCuUL3tZWJkHMgnWG9tooS4UiwFR3/nWjM6YjU
	VYcpA1W3QQws95LOEunOXY1b/LUAbbE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-whSMbX83MSSfCgg1WvfC9g-1; Mon, 18 Nov 2024 04:11:08 -0500
X-MC-Unique: whSMbX83MSSfCgg1WvfC9g-1
X-Mimecast-MFC-AGG-ID: whSMbX83MSSfCgg1WvfC9g
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-382450d158fso501303f8f.1
        for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 01:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731921067; x=1732525867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaPvO86EJKOHufTcTTk7TOivaHoUoSkP3MPU2pK0O34=;
        b=dFlsxo9Z4FMwyfsVO1jsSGoqNXIOb/GobMZFkunPiMtzuLVKFHN6epkHrlzg/w2XqF
         nDn2ZTvHpjlJ/HLAcjcHE9dGnH3YgQWDsLd7oku9AUOLSopsfz8yiFH/0iYLPH0CszOY
         40pk7fRrxCU1a3xysepOC0QIgjkux08r06iCC6DwkJ1AGzDzF7bajC+iSFOZB5qGtevu
         tIpuQuikrNdPk30r/LrY371/witbkhpX84D4i9y1AmeQ6cRhXtNHco9rNuY83N1PbC1y
         yi9u8/4JhhCGKrrdnVlAh00xalS1AejWy/fAMXhyXngW0fah4wCvYyxNBsdHoLXsiBEp
         Rkzg==
X-Forwarded-Encrypted: i=1; AJvYcCWwcXtIBRtUzt9te7k4wguUlHgwGODcFUD/eJ4g6Bit/wI1XTYuCBEtZjhXYVrbPKhkewHXDoPB@vger.kernel.org
X-Gm-Message-State: AOJu0YyD5JurttvzAwH+qMXHeb5GgiQmTkL0tyoHc1LvDLLaBLAcxw4E
	cYfEOKOTGDrkoJHoPwSnOnXK0K6dea+TcjddWBa+Gns2OIKjG0VpXhbTBSbYE7ZWnLn2iIRM+Q4
	sNhwNpDnIMS+nBmd3UIyTCanEXy3fN/lxrEDDsjXPgMs1lgA06wHpwyQ=
X-Received: by 2002:a05:6000:697:b0:382:4aeb:91c7 with SMTP id ffacd0b85a97d-3824aeb965emr175651f8f.18.1731921067330;
        Mon, 18 Nov 2024 01:11:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBFkYfubeKYO+1/Zbi1MMMRab+sljXJXFMhFzqShUuBgkM4JE8RmYzuikIvzc3S/jxthVH+A==
X-Received: by 2002:a05:6000:697:b0:382:4aeb:91c7 with SMTP id ffacd0b85a97d-3824aeb965emr175635f8f.18.1731921066975;
        Mon, 18 Nov 2024 01:11:06 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.74.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823a0e8f26sm5942270f8f.31.2024.11.18.01.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 01:11:05 -0800 (PST)
Date: Mon, 18 Nov 2024 10:11:03 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: Additional issue with cpuset isolated partitions?
Message-ID: <ZzsEpyU99iRLvK_3@jlelli-thinkpadt14gen4.remote.csb>
References: <Zzd3G67_UwBUJaRt@jlelli-thinkpadt14gen4.remote.csb>
 <bfbedc6a-9f04-472f-afe9-828efe0387e6@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfbedc6a-9f04-472f-afe9-828efe0387e6@redhat.com>

On 15/11/24 12:47, Waiman Long wrote:
> On 11/15/24 11:30 AM, Juri Lelli wrote:
> > Hello,
> > 
> > While working on the recent cpuset/deadline fixes [1], I encountered
> > what looks like an issue to me. What I'm doing is (based on one of the
> > tests of test_cpuset_prs.sh):
> > 
> > # echo Y >/sys/kernel/debug/sched/verbose
> > # echo +cpuset >cgroup/cgroup.subtree_control
> > # mkdir cgroup/A1
> > # echo 0-3 >cgroup/A1/cpuset.cpus
> > # echo +cpuset >cgroup/A1/cgroup.subtree_control
> > # mkdir cgroup/A1/A2
> > # echo 1-3 >cgroup/A1/A2/cpuset.cpus
> > # echo +cpuset >cgroup/A1/A2/cgroup.subtree_control
> > # mkdir cgroup/A1/A2/A3
> > # echo 2-3 >cgroup/A1/A2/A3/cpuset.cpus
> > # echo 2-3 >cgroup/A1/cpuset.cpus.exclusive
> > # echo 2-3 >cgroup/A1/A2/cpuset.cpus.exclusive
> > # echo 2-3 >cgroup/A1/A2/A3/cpuset.cpus.exclusive
> > # echo isolated >cgroup/A1/A2/A3/cpuset.cpus.partition
> > 
> > and with this, on my 8 CPUs system, I correctly get a root domain for
> > 0-1,4-7 and 2,3 are left isolated (attached to default root domain).
> > 
> > I now put the shell into the A1/A2/A3 cpuset
> > 
> > # echo $$ >cgroup/A1/A2/A3/cgroup.procs
> > 
> > and hotplug CPU 2,3
> > 
> > # echo 0 >/sys/devices/system/cpu/cpu2/online
> > # echo 0 >/sys/devices/system/cpu/cpu3/online
> > 
> > guess the shell is moved to the non-isolated domain. So far so good
> > then, only that if I turn CPUs 2,3 back on they are attached to the root
> > domain containing the non-isolated cpus
> A valid partition must have CPUs associated with it. If no CPU is available,
> it becomes invalid and fall back to use the CPUs from the parent cgroup.

Hummm, OK. But, if I don't put any process in the partition the behavior
is different, in that the partition still reads as correctly isolated
and CPUs are not moved to the root domain after hotplug, i.e.,

# echo 0 >/sys/devices/system/cpu/cpu2/online
# echo 0 >/sys/devices/system/cpu/cpu3/online
# cat cgroup/A1/A2/A3/cpuset.cpus.partition
isolated
# echo 1 >/sys/devices/system/cpu/cpu2/online
# echo 1 >/sys/devices/system/cpu/cpu3/online
# cat cgroup/A1/A2/A3/cpuset.cpus.partition
isolated

This is what puzzled me, the difference in behavior w/ or w/o a process
in the cgroup.

> > # echo 1 >/sys/devices/system/cpu/cpu2/online
> > ...
> > [  990.133593] root domain span: 0-2,4-7
> > [  990.134480] rd 0-2,4-7
> > 
> > # echo 1 >/sys/devices/system/cpu/cpu3/online
> > ...
> > [ 1082.858992] root domain span: 0-7
> > [ 1082.859530] rd 0-7
> > 
> > And now the A1/A2/A3 partition is not valid anymore
> > 
> > # cat cgroup/A1/A2/A3/cpuset.cpus.partition
> > isolated invalid (Invalid cpu list in cpuset.cpus.exclusive)
> > 
> > Is this expected? It looks like one need to put at least one process in
> > the partition before hotplugging its cpus for the above to reproduce
> > (hotpluging w/o processes involved leaves CPUs 2,3 in the default domain
> > and isolated).
> 
> Once a partition becomes invalid, there is no self recovery if the CPUs
> become online again. Users have to explicitly re-enable it. It is really a
> very rare case and so we don't spend effort to do that.
> 
> If only one of 2 CPUs are offline and then online again, the full 2-CPU
> isolated partition can be recovered.
> 
> Please let me know if you have further question.

I see the point, but please see above my only remaining question. :)

Thanks,
Juri


