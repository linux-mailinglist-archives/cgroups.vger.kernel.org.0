Return-Path: <cgroups+bounces-6171-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FFCA12BDE
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 20:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9CB18843D3
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 19:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB29C1D63F6;
	Wed, 15 Jan 2025 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NpjH76wk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672611D5AC3
	for <cgroups@vger.kernel.org>; Wed, 15 Jan 2025 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970099; cv=none; b=nT5pL8KjtWMHkr4B1xHuKpuwFQZy0bMtItpxbnRWVZ8kbW63/9KI5OqxrkcIk3eigOA4Gz6nTS8TU1607ZL0l/Oq0FUeidgqunvk7yGBJmOf+SY9j/wKnQ8zllCQnHJjTcsIag7JUsvQRYgSx0qRtOIiGg0a+p4rF8q0xJotHZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970099; c=relaxed/simple;
	bh=X79fQShG2win0Kg23ZMNAfHyL/M4PaoYCU5ajfjIgyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+Dds5U3mDde4J+FwApy+OISm4aO8R8Hg1Bst8anOLNdg3Zl8pNCzHOyTD+g/k1P8B37s2Z0bXRtW9lH97PnNnNp7DVWGN23rWIn+/WJAG1THWok53cnQMCN2pMka4N7tTd9DQXi1usb70p7QwaFwgOytdj4bYNhJlLiuhvjmBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NpjH76wk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso159249a12.0
        for <cgroups@vger.kernel.org>; Wed, 15 Jan 2025 11:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736970096; x=1737574896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZVNqrTwKIYDf4Bm8NNK5jPuTo2WMdjzDg2Q0uygxvA=;
        b=NpjH76wkqrBfvKJkqGH9//9ueHN18TRvKnHkgiO+gVUCAdb+oXnklWDqUJA9JSVp0c
         QUT0lgpNKep/eWomXY8ZjkORKkGBQ4AHYKooJjYQJR3ZuHGA+CMEbd1+8kUSO3KP/yd1
         OmVanT9p5dWYaHK9VhMDJzdCHF8vc28fsOQ06GQeI2Er+4uzS8qzmuKlpLG37AcajzrX
         oLc64YR91KgnmMo5rwju+YztZ6zLja2zUM3gNmvp/cj4dxdysjf9W2orRzTNM02Zl5ql
         siP7TDys5CDSQ0DiX7jfInoucv4TFNLy7JVvE99qnMtcUopsq+59r00PX4sB6giMSVsm
         d5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736970096; x=1737574896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZVNqrTwKIYDf4Bm8NNK5jPuTo2WMdjzDg2Q0uygxvA=;
        b=AMX+TPpx7Kzdi1Ti09Lp+zcUR3RE8hw/K6r7UgH0ML/2rzUEDlwcANWYM83dAgwdAA
         JA4Ezn78rJiBNDlc2/iK53dxWZ/NOd5dt+2cN4Gc/3ShOp31gR5h3+opwnrEEYFpAjmf
         etUe+34DHoUi0bxKGOc9ecbyW79qNUgLaJUODi61nBH2iuMQdczdM9IhXG/s93PBMOo0
         W7IikygYZFxZXdevA/BMxn3bUhysEv8rZ2/H+L/yT7PJSKwm/zkUD1G88QDEs3/Dfhnc
         h80o/EWb2pUFJtyuniTGFck4noLvnPjD5bbBLa63+MOjZKlzd0XXpqbnYs/QJRhhlAEs
         pE6w==
X-Forwarded-Encrypted: i=1; AJvYcCWvhfPXpUkhITsqeHvbNGoWBicq79p63iH4vawKQbe+7gf5/TDteRdrbLDiKnYoxbAWP59/rb0c@vger.kernel.org
X-Gm-Message-State: AOJu0YxjnttIlgDvS51mIen/kQ3RgGLWM9gp9bW3gDeYbzZFwgRFVDO7
	IYnc+sNkhJ2Hg/U0nztSwHCN6McYHI+R5EXOccrEdItfIWxo2sk32WwmWia5jK4=
X-Gm-Gg: ASbGncsoN7SetHzHttldRaULWi7jnM6XtbM4P9R1n8F2/c+xBc/Xp764R0reXrAGfvl
	ocxbJeSkCAK+HOhwZWEvgMEp0KFG4ZuW22Q/p0qvdpCs2sjEnAIMWu7AFEf10TIFS3Ub0AylWpl
	7PmBzEfbqLbw42GQK2QhTECTyu2u1iMIjR3xF1FAC13QHT99JTq8w6YVFvBBozZgMa77A/n/9R7
	pVBdoHVcMuVrqHmFm0KGRy1AMRphGsctJSC9K94rTOnj9NyJ9cF0ifF/tzWlAZ225iVrw==
X-Google-Smtp-Source: AGHT+IEQAuyjYMWDuvxbQji30YXDQg1tnXpQK7ijaXsvEZSUIwVzPcfJ06q+Oo+0/rOilCVxe3Nb/g==
X-Received: by 2002:a05:6402:4307:b0:5d9:f362:1682 with SMTP id 4fb4d7f45d1cf-5d9f3621964mr8968077a12.24.1736970095771;
        Wed, 15 Jan 2025 11:41:35 -0800 (PST)
Received: from localhost (109-81-90-202.rct.o2.cz. [109.81.90.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9900c4326sm7629912a12.23.2025.01.15.11.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 11:41:35 -0800 (PST)
Date: Wed, 15 Jan 2025 20:41:34 +0100
From: Michal Hocko <mhocko@suse.com>
To: Rik van Riel <riel@surriel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	hakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <Z4gPblXp1HXrgL_I@tiehlicka>
References: <Z2BJoDsMeKi4LQGe@tiehlicka>
 <20250114160955.GA1115056@cmpxchg.org>
 <Z4aU7dn_TKeeTmP_@tiehlicka>
 <af6b1cb66253ad045c9af7c954c94ad91230e449.camel@surriel.com>
 <Z4aYSdEamukBGAZi@tiehlicka>
 <193d98b0d5d2b14da1b96953fcb5d91b2a35bf21.camel@surriel.com>
 <Z4apM9lbuptQBA5Z@tiehlicka>
 <20250114192322.GB1115056@cmpxchg.org>
 <Z4a-GllRm7KABAu7@tiehlicka>
 <7a4e5591f45df455e6a485fc5400989569d3d22d.camel@surriel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4e5591f45df455e6a485fc5400989569d3d22d.camel@surriel.com>

On Wed 15-01-25 12:35:37, Rik van Riel wrote:
> On Tue, 2025-01-14 at 20:42 +0100, Michal Hocko wrote:
> > O
> > I do agreee that a memory deadlock is not really proper way to deal
> > with
> > the issue. I have to admit that my understanding was based on ENOMEM
> > being properly propagated out of in kernel user page faults. 
> 
> It looks like it kind of is.
> 
> In case of VM_FAULT_OOM, the page fault code calls
> kernelmode_fixup_or_oops(), which a few functions
> down calls ex_handler_default(), which advances
> regs->ip to the next instruction after the one
> that faulted.

OK, so we do not have the endless loop. Good. Sorry I didn't get to read
through the fixup tables maze. Thanks for confirming.

> Of course, if we have a copy_from_user loop, we
> could end up there a bunch of times :)

Yes, the robust list might have many elements and if each and every is
swapped out then this can take a lot of time if the reclaim path is
desperately retrying the whole reclaim. All that being said, does the
change (partial revert) suggested by Johannes

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..9c30c442e3b0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1627,7 +1627,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * A few threads which were not waiting at mutex_lock_killable() can
 	 * fail to bail out. Therefore, check again after holding oom_lock.
 	 */
-	ret = task_is_dying() || out_of_memory(&oc);
+	ret = out_of_memory(&oc);
 
 unlock:
 	mutex_unlock(&oom_lock);

Or is the exit still taking unbearably too long? If yes maybe we can
help to ENOMEM already killed and oom reaped tasks earlier?
-- 
Michal Hocko
SUSE Labs

