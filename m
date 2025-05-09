Return-Path: <cgroups+bounces-8111-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B32CAB1BCE
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 19:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FABC189C724
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 17:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CCE23498E;
	Fri,  9 May 2025 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzOSsgxy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078178F77
	for <cgroups@vger.kernel.org>; Fri,  9 May 2025 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813236; cv=none; b=M0lmQTwDxOpsndGmxg3FmwqFw8VZ59wNSzpApKLZNRVuMemb8AvLHRJxB+XmPeHFfjvGvgsvtOXvRhso9c9vlYML6KFp9Tf/oDm3NmBvCJZ4quh2+HerQDLM0X1tzdwJDif5ua5DgRp6A/p11EPiBO8stWAN5Pvvso6Q8xPTL6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813236; c=relaxed/simple;
	bh=B8Gfsu2ISY2ydQ1Lmgi2bR4n8vkNZ1culE8ZEb1PRJc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fsHN44OiMLj2GuoHau5ySLZpzs6/5ANr7qI4rcx99OH85gpzG65p+HSBzApc92GnCt3bWlw0CkPkg95ec11t3WP/YvTVyC+VyuL64Rr9uHMxSrGdtsI/DmW/0XERwR+xR+NGP7PieTOYFIltuCLchE8BpSoU4kHhkMo+vt+4rok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzOSsgxy; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736e52948ebso2910764b3a.1
        for <cgroups@vger.kernel.org>; Fri, 09 May 2025 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746813233; x=1747418033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AFB0VgN6jshFs8oHLmHjl8DGH2asagtJmEA8b7Wfb9c=;
        b=mzOSsgxyD8yjIFm/sL1/kqwTts/+HS2m0G9gDzxhpPu0qvQK5f699ge1L9SQIae1SN
         otruAzgVBMhMgkNMEuphO30da3rw9cw0a6Y+0LsFjOpI7BczJJCb5mJZL8M+sF+KVHdw
         HGoGxjyHuLr+/F4Sd77iy6TEhgapWkbbpr7oQrN85YdOX/eH/t9+uZ6bqIWUmcSy9ED8
         nO6DZ4/rgHLiXh9tCrK8zcAmKxogYBeceFvi98nk40qXz4qkkDr1AGg9Mwz2XKCT6swq
         unO92K4Ld89w6PEmAsrZSLFeDO7I1ISu+sJPXPhOgQglroSzQM2fVnux2B4ORMBw42c+
         aEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746813233; x=1747418033;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFB0VgN6jshFs8oHLmHjl8DGH2asagtJmEA8b7Wfb9c=;
        b=JMhszfORp2ZQSnGqR9rf826RtPgD1DhK9jTUIjEhYxzmPLtKs8Fw+IBsFOKcuyZVvo
         oLTPJKIBbUBn/QKIdNh4uAF1nRu8Eaw2E5bp+o24ZCBTcF6Cwbl/O/PkkNRRDs5R6EI4
         bRZdOE8wALgZb1z/FFq85Mf159ni/cVzYF8i0YrYHqB58uCkNyLkkvRx4+Cyjc9zp7hP
         H0Qxstgum2EYajPZnxg8cUcEY/xJcktc23RJG7nZPhGA69fgvJ4yr+Z4p2qbuh54TCbw
         Esr9GGfpLDmcGu2jqHOF/rTLHp8CywRLBs6Kk4YCJrpFCrXplSRKfnwxq3SnF26BolaV
         q8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVh+V+UPmBShmS731TQLdNr4up1TQAHQxWAtc4aiwuI8dtgUFXZHdFXPLwvzeRCWHkb3F6gzCuA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrf+TbxSkpOz+GSnQ3iO4bd/BAAf0T5RS8aLKxiL+mXzwF2aNi
	00ErYkBSJ2irinnVLOPa267U9YLz2t2pL78N5gNT2vxzJiEzwO/+928TXw==
X-Gm-Gg: ASbGnctSY/WapSYzUO0CFk13BkAUFSdA1fOcvTnq9E8PGJVKzjENGLsZYTzvRtGRwY2
	m59LBj8dtIKnpYVM0ukE8N0Cqp8thGdWoEwEfFN49CkKzGb7CJp0JkKLAnextvSM6SPh5v+jT+5
	tJywqphz5gwwSKN0mLKFtnGPej5xDsCqL868ZubTibiHgUzPc7rarH2TuSk3Ovb65NquyVlfql6
	ObJuB+sbZkH633hPMWfMevl0A+flCDhLLoOshb7TSxYznq77hcOzGE22zY+87XNS378RLYWgKx9
	AgdUch9I3t1ngV59gplcuUQjObLloa08wl0cnDEd0HrOxNvc78tAXMq+hzhYGnDP0r5Xt8+fIL5
	2ymPexI6JXdU=
X-Google-Smtp-Source: AGHT+IF8Pqbc0KrpXByjaRVZMvgR0r7bGqi+uUdALYete6gAYw3tv3cg9NGYp0wW7orxCO5/5kksuQ==
X-Received: by 2002:a05:6a00:3d43:b0:740:5927:bb8b with SMTP id d2e1a72fcca58-7423b3f75b3mr6043089b3a.0.1746813233145;
        Fri, 09 May 2025 10:53:53 -0700 (PDT)
Received: from [192.168.2.117] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a402d6sm2039371b3a.146.2025.05.09.10.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 10:53:52 -0700 (PDT)
Message-ID: <77ddbd18-894e-4187-a5b1-66e52deec980@gmail.com>
Date: Fri, 9 May 2025 10:53:51 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: JP Kobryn <inwardvessel@gmail.com>
Subject: Re: [PATCH v5 2/5] cgroup: use separate rstat trees for each
 subsystem
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mkoutny@suse.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250503001222.146355-1-inwardvessel@gmail.com>
 <20250503001222.146355-3-inwardvessel@gmail.com>
 <aBsm22A8qWjGJgY9@google.com>
Content-Language: en-US
In-Reply-To: <aBsm22A8qWjGJgY9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/25 2:24 AM, Yosry Ahmed wrote:
> On Fri, May 02, 2025 at 05:12:19PM -0700, JP Kobryn wrote:
[..]
>> @@ -6101,6 +6087,8 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
>>   	} else {
>>   		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
>>   		BUG_ON(css->id < 0);
>> +
>> +		BUG_ON(css_rstat_init(css));
> 
> We call css_rstat_init() here for subsys css's that are not early
> initialized, and in cgroup_setup_root() self css's. We can probably move
> both calls into cgroup_init() as I mentioned earlier?

I think it should stay here for two reasons. The first is because it
must precede the call to online_css(). There is a stated assumption that
css->css_online() is called (within online_css()) "after cgrp
successfully completed all allocations" in the admin-guide. There is an
example of this assumption in memcg_cgroup_css_online() in which the
work for periodic flushing is enqueued. So if online_css() is called
before css_rstat_init() there would be a race between flushing and 
initializing rstat for the css.
The second reason is that calling css_rstat_init() on a subsystem css
must also follow the call to init_and_link_css(), or else the css will
not have any subsystem association at the point of rstat init. It would
result in a subsystem css appearing to be the cgroup::self css since the
cgroup_subsys_state::ss field would be NULL.

> 
> Also, I think this version just skips calling css_rstat_init() for early
> initialized subsys css's, without adding the patch that you talked about
> earlier which protects against early initialized subsystems using rstat.
> 

Right, that was a pre-existing constraint but I'll create that patch and
prepend it to this series in the next rev.

