Return-Path: <cgroups+bounces-3736-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6552F934035
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 18:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB0E282FC8
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 16:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1954181CE9;
	Wed, 17 Jul 2024 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q6M546F2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87228181BBF
	for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721232861; cv=none; b=V7uyYttVPFryExXGvTu18ZJVqVuMNktvlN2jmNhAmpPVCQxBWtoKJxsqHPHM+nJoaYv15KSg7fR+OUdTKX0q+cQTCh5D71cxoEjYZMQnKGxGU6tGFEsSaICkR2papLItB1kU1KckqP4u2kQpQRhKG5amwgmS8IeGqzQnYe8TqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721232861; c=relaxed/simple;
	bh=q8fVv0T5FVDBujEE/b4d3zMSxxuIbpFIDCgMVagifYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0kOJCEFmmeC9L8+IE7X2sFWg+L4ciDdH5uY+nf6+UIpx6QYhxWToo4JsTgi3cdHQXBSG5FNsVzTPxvNsEzwzOlvbvrYG/NsLt66FI0B8HYJfmCTFiy2WmBaIqJvWk9dj1kpzxs9BqpWQ33BRIOP5xiG4K1SDRWvU09SNJH4mS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q6M546F2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso654303a12.1
        for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721232858; x=1721837658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LEwhtems285VRp+VcimErqgA9+/z6aK+6Ol/iXReRes=;
        b=Q6M546F2sELtiBpjZj7tshnmLGplWsbXze3I4jCWtJdHg5FRfKONk8g8gqUYxQPl0J
         aSb4d9WWgODb+mvzYf7znlI/EdO4u0yvWceQnNgY+13FAxbW36rDp9mcnfM4Ku7bdAUM
         tdjM3ZfJym+lqyJC6Ip0c+pfuA+TZTzw+DI86L9DOFprp0ALKFOUXvNSmuZkjaImZsvZ
         ORIsfJJfqceUt3e/Y52c9x/awsrh6+KQ/EjWpu2ShCwkMRZBE3xsDm0HQDYwT/HaCwWC
         hqKroIHJH2EZtbGq2Dh5F6kJMpY63YaZf9/Tl+vYgoofj6rNG4WuNryPY8tskwfhb5TW
         Gfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721232858; x=1721837658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEwhtems285VRp+VcimErqgA9+/z6aK+6Ol/iXReRes=;
        b=m83+/IXfEJvWqS9sY8eYpkvVt5eaQQhmHQ1c7a6c+axKFLTCr69PBPqyPOR1EF/7pQ
         gunAmaRDff2ySpucktpzMrivittIqf/5L0EKfRsRTVYS5mDVECUiB7KRXsNygo5YFvaJ
         nuIrdRrvNJXk6/8BfVlsj3q9oJM8dv1G6S9BJmejiAkhfpseqV2YwwkCZYJlyhuxqtYJ
         R/uUjJjHVjI0T1N2OfSAB02XbRjp+neJQRMB7a+G9ZDySvzX1a+wLiMGQTEB2DjmRBW3
         DLvVN/O1E8HuDAEZVBbvELwlDnF/KqRSxu0N28jB9QMQ8q5GOTjb3EktOcokWvni+Rwt
         6gxg==
X-Forwarded-Encrypted: i=1; AJvYcCXNuI4YEVeFzw2T4wFoJ5NJK3b8y8R3IcNqYCObijKtjbaIpxO/RFfbYu3Pm1nLfxw9ymwhHomOtGRAGCbaNNIsmM8l0spesA==
X-Gm-Message-State: AOJu0Yy6kRRoy7SWUn6xvtXLiR/35nk76O+iKmEafP4rDZEOUi7LwqlR
	z6R7PUA61ac0Br4BIL76vBVxoZgpW0/+dDQD1lLq7Xp+lZeZzaA+6FBqNJkPyD4=
X-Google-Smtp-Source: AGHT+IFvguqbwiQzSbD3S1ODpOLNKCNwaosZroB1gY+Xq6Ja1OO6D7EXUW+FPqr+DM5hB6DiiOcNoQ==
X-Received: by 2002:a17:906:490d:b0:a77:c0f5:69cc with SMTP id a640c23a62f3a-a7a01352eb4mr151904066b.61.1721232857851;
        Wed, 17 Jul 2024 09:14:17 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f21afsm456637366b.119.2024.07.17.09.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 09:14:17 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:14:16 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
Message-ID: <Zpft2A_gzfAYBFfZ@tiehlicka>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>

On Wed 17-07-24 17:55:23, Vlastimil Babka (SUSE) wrote:
> Hi,
> 
> you should have Ccd people according to get_maintainers script to get a
> reply faster. Let me Cc the MEMCG section.
> 
> On 7/10/24 3:07 AM, Qu Wenruo wrote:
> > Recently I'm hitting soft lockup if adding an order 2 folio to a
> > filemap using GFP_NOFS | __GFP_NOFAIL. The softlockup happens at memcg
> > charge code, and I guess that's exactly what __GFP_NOFAIL is expected to
> > do, wait indefinitely until the request can be met.
> 
> Seems like a bug to me, as the charging of __GFP_NOFAIL in
> try_charge_memcg() should proceed to the force: part AFAICS and just go over
> the limit.
> 
> I was suspecting mem_cgroup_oom() a bit earlier return true, causing the
> retry loop, due to GFP_NOFS. But it seems out_of_memory() should be
> specifically proceeding for GFP_NOFS if it's memcg oom. But I might be
> missing something else. Anyway we should know what exactly is going first.

Correct. memcg oom code will invoke the memcg OOM killer for NOFS
requests. See out_of_memory 

        /*
         * The OOM killer does not compensate for IO-less reclaim.
         * But mem_cgroup_oom() has to invoke the OOM killer even
         * if it is a GFP_NOFS allocation.
         */
        if (!(oc->gfp_mask & __GFP_FS) && !is_memcg_oom(oc))
                return true;

That means that there will be a victim killed, charges reclaimed and
forward progress made. If there is no victim then the charging path will
bail out and overcharge.

Also the reclaim should have cond_rescheds in the reclaim path. If that
is not sufficient it should be fixed rather than workaround.
-- 
Michal Hocko
SUSE Labs

