Return-Path: <cgroups+bounces-6154-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76172A11116
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 20:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2655A3A992F
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 19:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4281C1FCF79;
	Tue, 14 Jan 2025 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="sazLHi00"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394CC1E495
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882612; cv=none; b=oEbRvwvvUhYKcKRb51Ytsbr7lbsx8UovMx+7A5RCHgcLnvlTicQ71hNxRcxzC2lBdDvX+tT1Hya6VBx7LHMZZwpXuYLw7lY0z0FkIoBd67W44e0LwRHGje4Ly/MEfK/gtv5lD4MkneUApMlFz7eGrb+EYcF2WX3F5Sql+yJGwq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882612; c=relaxed/simple;
	bh=YDhfuqzlOb1+Gs0RHQUIPsLHSPiXLv6iWKGOpM/dwOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOwPJF+czAfU7p7/zkDZyCTnwmBdmfn3GMSA1qtuN2+W5FDNQWNRC9a5SD+yR9hyfg5Oaf+FRGzUJRXi2PE2PG/wI7VWIYi0GB2irlGpWFokmCd2RhmW66PGTS8JSSd7mbW9BrhTvnnWssuI+fRQRtWtaGB+zRjNt9CTQw86WyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=sazLHi00; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7bcf32a6582so286259585a.1
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 11:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1736882607; x=1737487407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pRH5WXAIfJW9sI4d3VG1suC4yIuhuyX08y9rusU5HkA=;
        b=sazLHi00UxphXbj3SOBxN4IMwpLOSZ5WPuptPzmnzEyuEfVH1lgCx+26vF+LLjbqST
         aFlckgEsS5Py5/HTJ3ir3LajlZXT0FdDywTvRZyq85gjiGtc+zCxtvi5rn0tul0OchCJ
         NqR6l/oumWOu1dc8Jm6px5qrICzHG3WkXMPzgVl9XpugL2eo9EvX0YjL1Tf9mxgVDmRd
         ABlifiHXn+hDybTic+jXF2s+/h4sYZUbN63/NLIXoZkW8/P//cwvU66+vXBSR1Fvb1FR
         knBsL5SqK/u6mY2Yas1lRqBeR6aWF+CVxNBxryn2BxoAm0FmlkJ94FKQLHiHzq4ZQAX+
         Ch2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736882607; x=1737487407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRH5WXAIfJW9sI4d3VG1suC4yIuhuyX08y9rusU5HkA=;
        b=tIHouXW3AVflG1UrGeLZEtl/sWGRS5ZNJMNUAgDV+U13kK7ob+YGpxFDe/7LT6WHPL
         uNVie03Qsv2g3IFJ+tccODTrXn1dUL4Cr/v43rdY7oCd4emZ9bwfeXAQfImElyllPIOW
         zgY02rMz2APsxwI5sA9OXxUfvro0quDlUCeitDF4Qsvn1Is57bEl1pihE+nHafA3PXmX
         RNtTNu0SyhfIWS8VMeUpLwkYillxQ9SNiHrSifLDhdSXb0bN9lbmysPLE6YVi97+FeFz
         mei755qJz1X0ppvqxSKznYkaYzSVoOqiyOUwT6c9Dk3ot6RURvlkH9E+jrPey5CadZj5
         Pn5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXs2dwrQa85ncss2pVJAiIrHXB+HxZg/DhMyKJ3axoIeo/jpQDYn144flUy0rpK7NEBANAGM/+b@vger.kernel.org
X-Gm-Message-State: AOJu0YweNw657XW+gZ4wJIjni+9lRxqoOSJVOiSm6Ws2LXtCJPib0ZU7
	Bb4IQeth7YBzIylz7BHVJTJE/npJUJTsj7fbBI25zfhuawdxrYc7PSzYdAxCJYU=
X-Gm-Gg: ASbGncs2EMqCBJBTT8BqoDvxChd6FWHWnKMOpFVxF2Hj/Yw56mnYbPw7i5FuXydDHQe
	uO3AGEuOrSE067xwfEO/gN1XKrbkv3vtKdAS0laPNMOg1CTT2oPifJbf4Lv/J9vsUVOt9SSzqJT
	4YI1rRNlyOvJfrNvLXpMmTqsoqyAzkDGBdJ67UrDAoFU3U/jABcrVdBXLZft+ZsrTGuB28LP0qC
	r01PESbNHZxhAKjhJxWenWfqgr0MWmsPx8/MQldNnAEKttHqXkiaoM=
X-Google-Smtp-Source: AGHT+IGLXLFv2cUPWN27tEDLm5LK2vwWsP3tTlNAMSZlbuEbtvxtpoDkKUXi/q1Kv5wrEtQZjuRT9A==
X-Received: by 2002:a05:620a:31a9:b0:7b6:ea91:d886 with SMTP id af79cd13be357-7bcd97b5a4amr4124433785a.39.1736882606918;
        Tue, 14 Jan 2025 11:23:26 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad86153asm56206756d6.22.2025.01.14.11.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 11:23:26 -0800 (PST)
Date: Tue, 14 Jan 2025 14:23:22 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@surriel.com>, Yosry Ahmed <yosryahmed@google.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	hakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <20250114192322.GB1115056@cmpxchg.org>
References: <20241212115754.38f798b3@fangorn>
 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
 <20241212183012.GB1026@cmpxchg.org>
 <Z2BJoDsMeKi4LQGe@tiehlicka>
 <20250114160955.GA1115056@cmpxchg.org>
 <Z4aU7dn_TKeeTmP_@tiehlicka>
 <af6b1cb66253ad045c9af7c954c94ad91230e449.camel@surriel.com>
 <Z4aYSdEamukBGAZi@tiehlicka>
 <193d98b0d5d2b14da1b96953fcb5d91b2a35bf21.camel@surriel.com>
 <Z4apM9lbuptQBA5Z@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4apM9lbuptQBA5Z@tiehlicka>

On Tue, Jan 14, 2025 at 07:13:07PM +0100, Michal Hocko wrote:
> Anyway, have you tried to reproduce with 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b3503d12aaf..9c30c442e3b0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1627,7 +1627,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * A few threads which were not waiting at mutex_lock_killable() can
>  	 * fail to bail out. Therefore, check again after holding oom_lock.
>  	 */
> -	ret = task_is_dying() || out_of_memory(&oc);
> +	ret = out_of_memory(&oc);
>  
>  unlock:
>  	mutex_unlock(&oom_lock);
> 
> proposed by Johannes earlier? This should help to trigger the oom reaper
> to free up some memory.

Yes, I was wondering about that too.

If the OOM reaper can be our reliable way of forward progress, we
don't need any reserve or headroom beyond memory.max.

IIRC it can fail if somebody is holding mmap_sem for writing. The exit
path at some point takes that, but also around the time it frees up
all its memory voluntarily, so that should be fine. Are you aware of
other scenarios where it can fail?

What if everything has been swapped out already and there is nothing
to reap? IOW, only unreclaimable/kernel memory remaining in the group.

It still seems to me that allowing the OOM victim (and only the OOM
victim) to bypass memory.max is the only guarantee to progress.

I'm not really concerned about side effects. Any runaway allocation in
the exit path (like the vmalloc one you referenced before) is a much
bigger concern for exceeding the physical OOM reserves in the page
allocator. What's a containment failure for cgroups would be a memory
deadlock at the system level. It's a class of kernel bug that needs
fixing, not something we can really work around in the cgroup code.

