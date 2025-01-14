Return-Path: <cgroups+bounces-6143-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AE2A10CE5
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 18:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D137B16419E
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 17:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F46170A2C;
	Tue, 14 Jan 2025 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FUMf1qKD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D09919149F
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874064; cv=none; b=VMcwerg4IPulgLJOvIPp4keHAPivucyTQWjb8S/33roFI71PHYmmTcYZMJLMHR5ZgHSFI3nb5B/68CwYC8iWMRpPIsxuKst8nJUqiD98iX4aTXsGYT/NGZ39/nfXI53IsYX4vouYkuzJ7bVM7Llp6ODF5Ub330vs1zQ8W8sz65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874064; c=relaxed/simple;
	bh=YJg4n6bu0eMo7z3f+6I5T+x9HeNtHJi9Sys/+7t7R64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyJLog3UcILdGg5f4G5uL7cKdLFqMFq2DVdpBUgiGFWLyqpyb7Pkzk76fyUYNKWJiVy4h55dZ4zeOTar/Cx/YrNshrkAmUAfJdiQZZ2UFN4CHOoCD+rdRKAmbihXNlVg76M3r1BKDDIu5gwkE+53iTw1/SV7pjGZmezGSGm7W2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FUMf1qKD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso9663453a12.0
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 09:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736874061; x=1737478861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUoI2EyKt/knlrGvqwIP6n1ZeNaysEcJuerUgijRn1Q=;
        b=FUMf1qKDgYSZ/oMiCZELa3jNT4STd2QM+jbynpNFHDdhChjO3Y5S0ACYRrMWEerwUD
         aQx9cYbXL3dvkcbvk8T6U5eaX+6sQI/UYJND4sFOJi7pCIf8gBZEx5H4pwUN6Bh3I33V
         a56K1O1GB15ggmd9tVxotbTH36gKNc2+ZaI51UFvA3DSqLFSU2A5FchG6/GB4riGCyOV
         nJHpuByepekPma/dwVxmiP/ONI462M7Npvk8dQ0GbleMNyqLNp2cTAi8fWi/PcYpETN/
         Eq9tNyewU3drXNUrdbB6GtGLSMDEmCkBxRhme0Qb5fqi7pvJJgVXt6lfgnzGstapcY0H
         SW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736874061; x=1737478861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUoI2EyKt/knlrGvqwIP6n1ZeNaysEcJuerUgijRn1Q=;
        b=Jh1QAaCy2C2/Ko4+W8UsEN0nyNwO/k7yUKOD5uDo060nKOq0765zK59NDmu4EjkhhS
         y6wSyrASokOQHJj09R4foUeoCQSQ1rSyLpKe7I55AtdM8ml2fSsYNKwibHvMvmEC4EWK
         PSs2Z+3hlDSYkLSVx4i2rZyqi32crvEdsxBCP1dgxWXASjZ0cYr2UBYGlrR1iqIZo7Xd
         XQwoUBlRO2J3FIEs+L87nTUmi0zH96jasW480pePnLoT6Mqv0F7PMA39PiN9dfOejxZD
         glbd4znevKf6xWKFE1e34XAmMo8Q2O2VkPT88k6BE4dA6YCiY2HOfZV2UPHhTb6z+HBZ
         GxIw==
X-Forwarded-Encrypted: i=1; AJvYcCXRlkOl3KLswvHCsRjV5iRasMsfPKzRQAAbtKLW9cnAQR7GNWq8w4gM3Q91N+HFiP/LRUlZckYt@vger.kernel.org
X-Gm-Message-State: AOJu0YxUPrQBXNwtzKd58vfREvag8JIMnd3te3dJdRb7YZz2c3HL8tk2
	GZVrGljTKok3Jgd3PVFkMp/XFXH8pOXnTy1zEQUOm28WTFjp6/6/5yH3rvHOBgk=
X-Gm-Gg: ASbGncv5jOfEofB/9InECm8Ze0Ao/aJYqtHGUShnHWWFzHzkQyff9cRp9i1GT58ibtd
	iK0Oq9uBVtBHs20ZCohnivZIVbZb+JORjooFsy+L4yez8bCwrie9Pd8yUD1VSxwcdY4zoZNv6ck
	Qs4GnhvzqDjBwHROHj6C55KO8NqRVoqqeYa5sTcsXHoT8ospUjgQTuxLqqx9upk+BeSaD8F3cC3
	cdMGIOOUWD5+3aFyuccDFPTHaP6MqjRJ6Xr8ySz4gzcPaBOOUtMZ0A47a+uMiLZdtI7+w==
X-Google-Smtp-Source: AGHT+IFlsRdDjUfkFl69+IV4zPFF4B9GZCFDetrBcvlk1aTeSGtQUB5pfsswDlESXqm2+oa8lB9xPQ==
X-Received: by 2002:a05:6402:358c:b0:5d0:d84c:abb3 with SMTP id 4fb4d7f45d1cf-5d972e4c9a7mr22660785a12.26.1736874058860;
        Tue, 14 Jan 2025 09:00:58 -0800 (PST)
Received: from localhost (109-81-90-202.rct.o2.cz. [109.81.90.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99046dbe0sm6202402a12.64.2025.01.14.09.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 09:00:58 -0800 (PST)
Date: Tue, 14 Jan 2025 18:00:57 +0100
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
Message-ID: <Z4aYSdEamukBGAZi@tiehlicka>
References: <20241212115754.38f798b3@fangorn>
 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
 <20241212183012.GB1026@cmpxchg.org>
 <Z2BJoDsMeKi4LQGe@tiehlicka>
 <20250114160955.GA1115056@cmpxchg.org>
 <Z4aU7dn_TKeeTmP_@tiehlicka>
 <af6b1cb66253ad045c9af7c954c94ad91230e449.camel@surriel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af6b1cb66253ad045c9af7c954c94ad91230e449.camel@surriel.com>

On Tue 14-01-25 11:51:18, Rik van Riel wrote:
> On Tue, 2025-01-14 at 17:46 +0100, Michal Hocko wrote:
> > On Tue 14-01-25 11:09:55, Johannes Weiner wrote:
> > 
> > > 
> > > We managed to extract a stack trace of the livelocked task:
> > > 
> > > obj_cgroup_may_swap
> > > zswap_store
> > > swap_writepage
> > > shrink_folio_list
> > > shrink_lruvec
> > > shrink_node
> > > do_try_to_free_pages
> > > try_to_free_mem_cgroup_pages
> > 
> > OK, so this is the reclaim path and it fails due to reasons you
> > mention
> > below. This will retry several times until it hits mem_cgroup_oom
> > which
> > will bail in mem_cgroup_out_of_memory because of task_is_dying
> > (returns
> > true) and retry the charge + reclaim (as the oom killer hasn't done
> > anything) with passed_oom = true this time and eventually got to
> > nomem
> > path and returns ENOMEM. This should propaged -ENOMEM down the path
> > 
> > > charge_memcg
> > > mem_cgroup_swapin_charge_folio
> > > __read_swap_cache_async
> > > swapin_readahead
> > > do_swap_page
> > > handle_mm_fault
> > > do_user_addr_fault
> > > exc_page_fault
> > > asm_exc_page_fault
> > > __get_user
> > 
> > All the way here and return the failure to futex_cleanup which
> > doesn't
> > retry __get_user on the failure AFAICS (exit_robust_list). But I
> > might
> > be missing something, it's been quite some time since I've looked
> > into
> > futex code.
> 
> Can you explain how -ENOMEM would get propagated down
> past the page fault handler?
> 
> This isn't get_user_pages(), which can just pass
> -ENOMEM on to the caller.
> 
> If there is code to pass -ENOMEM on past the page
> fault exception handler, I have not been able to
> find it. How does this work?

This might be me misunderstading get_user machinery but doesn't it
return a failure on PF handler returing ENOMEM?
-- 
Michal Hocko
SUSE Labs

