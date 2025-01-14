Return-Path: <cgroups+bounces-6148-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455D4A10F9D
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 19:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C527A06FA
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 18:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE5820F078;
	Tue, 14 Jan 2025 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VXPn7Xr/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BDE1FCF79
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878394; cv=none; b=mkOXc1HX/fTAg9L4w7aPgsQSmxz9NI1jS8Q2giEGU45yiHgwjK1yQoyPKamaT3kkKXRNcA+7pTfC/lq3yJpoS7MzdEp7j4G1o4S1SmM2IO0+evvtNIOgPa3caUnL8k/b/gwq3KHNsC4NEeXj/P1uBtkbRYK5V6brMc5ryE1/3QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878394; c=relaxed/simple;
	bh=bQ6W1NiCOf1EObjIIE/DMh3nvS6huNmcJeUX53i8VZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lq74e8ivC7K3QQKi7wOC2OSQuLrLzOT8koYifQD7Ot2w52cllix7yY2scZRYr+A4SBbckqtCSAJxgp74UCZNVLyCvru6LyIW4AiJyLQxvL9sex+FuGT4/T/eriFCHoS9DfE/laN+0ukGKBoY/wGeC6NABiq0XYFcAcZSKE0cY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VXPn7Xr/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso9634111a12.3
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 10:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736878389; x=1737483189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/PzmWEG1n7zg8r6BypqksffUkD59L7DefGMNLqR9DfU=;
        b=VXPn7Xr/DnrlFBG/IG8PenfU+fH31X2shNkthIsf89LTzR/38vfxugK4iKYzw5Y+qa
         cg9h48p6/PheZPpeC9bgE7WEQ4UpfA77xuK6ny2TkOX//B3/pJgt6YZ8Ki67LM9qu8sn
         xAoXIRSoSUlhVpphqAdq0Nj5ZMnSqshHs5SraAps2VdWD9750sR+cpBNYFus8sLSeJXi
         3Nif9OzgGCrm4X9f3HP+3UzSV6YAiGrSfaTmhuaPZ05qrf36fOV0S3ygbNX6Y3LfnP6m
         jif6l5EY4AiqN2ER5f3o7qf/LbzzfaKpIs2Yhzp5PIgN53SoOoKE4W5elo42O5QjOZ2R
         0A1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736878389; x=1737483189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PzmWEG1n7zg8r6BypqksffUkD59L7DefGMNLqR9DfU=;
        b=wM951uvPF5JRB7+Tq4Q+oNT7PGg/WsXGb1jpKKA5zttvafDDcXjRlZI660eCrGgQJy
         32YGRtO7vE5cC2sRtzhf6RYKfRSk6WAiYh3ARnZdbfmAt+6/pXfWbQOYvOx+fcfR+ji0
         al4sYRvVCL4YruhaaDEdpSGuJkbHDwXW5+Lhn4zeiEU9J5d99JKQ/gJ+/8xWPPiJ52rb
         rULGjEyKNBPEckK5qJKFBj+ayhmgi3Q+AlP803jdQQQnob9cVipDURYsy/Ls3uCUNuO3
         8DSXtS407FyNGmoSNJw/Q7ZgBbTBLnMIhfIgdrniTv6gPCSWd0NxVRgvfV16nEh2tovQ
         k4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWlGa/1CJDJCNurb2zjEnmU4E4f2ARGuI4dlugEjqGcLU6bTb7UxPhDz/FuXlmbbj3+9nkXoMfu@vger.kernel.org
X-Gm-Message-State: AOJu0YziQIz9EcpHjr3jaJd6+/tW88AFeku7pO8oxa6Bx5rKyt5LdTdt
	ypYXW7Zlb0aU603jMk65nmxYAYzk3nyEk5v1QgmiGph0eCmmyJtoOkx2LMZQkpY=
X-Gm-Gg: ASbGncvxZGQFFiwLDbb1F5bfefRV2UgOGGVjTGVREjwBoOHCGZmQYSR9yrKMMCirYJs
	Ht3cUMK+AzPugUTS9GExcuWhp/cxzzBIxtXxr20RjBj6osAYDBR9MkSzukpJaVlVJx8k5T+m1iF
	p0waIugfTZoKFKShrX1/itMlZDuRXSvwNsDY1G6RKIUHc8W1sqWNQAefnxrbCvKoWn6X0h76sEC
	fHu+jN+itCm2AHiB+GujWIQld5/EwmxsPEA9A3FMfqr3dxjN4CTpFLcCHvWCF2Rxw2ZiQ==
X-Google-Smtp-Source: AGHT+IGVtpgZLwqzBv1STerXMBG5F3Xv5KeJkgN+BsIiRzsnFO8C/jiKmuKjicONNJ0I6otqhuGAmA==
X-Received: by 2002:a05:6402:520d:b0:5d9:ae5:8318 with SMTP id 4fb4d7f45d1cf-5d972e1da12mr61657177a12.20.1736878388840;
        Tue, 14 Jan 2025 10:13:08 -0800 (PST)
Received: from localhost (109-81-90-202.rct.o2.cz. [109.81.90.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90d9ae0sm664853766b.68.2025.01.14.10.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 10:13:08 -0800 (PST)
Date: Tue, 14 Jan 2025 19:13:07 +0100
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
Message-ID: <Z4apM9lbuptQBA5Z@tiehlicka>
References: <20241212115754.38f798b3@fangorn>
 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
 <20241212183012.GB1026@cmpxchg.org>
 <Z2BJoDsMeKi4LQGe@tiehlicka>
 <20250114160955.GA1115056@cmpxchg.org>
 <Z4aU7dn_TKeeTmP_@tiehlicka>
 <af6b1cb66253ad045c9af7c954c94ad91230e449.camel@surriel.com>
 <Z4aYSdEamukBGAZi@tiehlicka>
 <193d98b0d5d2b14da1b96953fcb5d91b2a35bf21.camel@surriel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <193d98b0d5d2b14da1b96953fcb5d91b2a35bf21.camel@surriel.com>

On Tue 14-01-25 12:11:54, Rik van Riel wrote:
> On Tue, 2025-01-14 at 18:00 +0100, Michal Hocko wrote:
> > On Tue 14-01-25 11:51:18, Rik van Riel wrote:
> > > On Tue, 2025-01-14 at 17:46 +0100, Michal Hocko wrote:
> > > > On Tue 14-01-25 11:09:55, Johannes Weiner wrote:
> > > > 
> > > > > charge_memcg
> > > > > mem_cgroup_swapin_charge_folio
> > > > > __read_swap_cache_async
> > > > > swapin_readahead
> > > > > do_swap_page
> > > > > handle_mm_fault
> > > > > do_user_addr_fault
> > > > > exc_page_fault
> > > > > asm_exc_page_fault
> > > > > __get_user
> > > > 
> > > > All the way here and return the failure to futex_cleanup which
> > > > doesn't
> > > > retry __get_user on the failure AFAICS (exit_robust_list). But I
> > > > might
> > > > be missing something, it's been quite some time since I've looked
> > > > into
> > > > futex code.
> > > 
> > > Can you explain how -ENOMEM would get propagated down
> > > past the page fault handler?
> > > 
> > > This isn't get_user_pages(), which can just pass
> > > -ENOMEM on to the caller.
> > > 
> > > If there is code to pass -ENOMEM on past the page
> > > fault exception handler, I have not been able to
> > > find it. How does this work?
> > 
> > This might be me misunderstading get_user machinery but doesn't it
> > return a failure on PF handler returing ENOMEM?
> 
> I believe __get_user simply does a memcpy, and ends
> up in the page fault handler.

It's been ages since I've looked into that code and my memory might be
very rusty. But IIRC the page fault would be handled through exception
table and return EFAULT on the failure. But I am not really sure whether
that is the case for all errors returned by the page fault handler or
only for SEGV/SIGBUS. I need to refresh my memory on that.

Anyway, have you tried to reproduce with 
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

proposed by Johannes earlier? This should help to trigger the oom reaper
to free up some memory.
-- 
Michal Hocko
SUSE Labs

