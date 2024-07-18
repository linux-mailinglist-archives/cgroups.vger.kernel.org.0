Return-Path: <cgroups+bounces-3774-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0117A934ADB
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 11:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA0F281950
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 09:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6B0839E4;
	Thu, 18 Jul 2024 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NUEZD7rY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44F81205
	for <cgroups@vger.kernel.org>; Thu, 18 Jul 2024 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294751; cv=none; b=N/sL7Bprsvi0wArq4oJo/8uiClr6a8wOyIgtmGili4aPDCiD0PRpIqVC0u0QypVZh0tHWjom3KWmLJCQYMk3SG/C8IH9GIiHrlwBCeulbuIm8F44uQdw+RdvRCIgXRab1GjNfXGIRpH+XqurrArrtvbOHd0VkDpufFaVN8zIqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294751; c=relaxed/simple;
	bh=XdUs22hWj4yPiEVcEpPwpByY3n2QmXcOM+pCzJhqQyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOarCT5JXy5GR51GDSWYRDGssTrxC6+T0gCrtUW9tXvTZc0QbjAicUKw6UQylJoS3xazZkZyfZAQtfOjH3eaES1+GRMbXUYFcK1UTNM1ackYFWc4aXXzi+CCatKz1qUhWIQV/ztVe1IauLc0KRe0fxa0Xp/SRiIgdmg7YLvaW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NUEZD7rY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a09634354eso618092a12.3
        for <cgroups@vger.kernel.org>; Thu, 18 Jul 2024 02:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721294748; x=1721899548; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+AQXyp5zTd9VUi1GRGHEcdKdd16XlM0Bs2GIA+qkJx8=;
        b=NUEZD7rYYhbHJvg00+12T6yI0Dhi6ebKjYapnfLYAVjXGXagq8C4R3u9/NiDAEPO5v
         HQycH/h7tgielbUKpaoqELX1x6d6Foa5JNn+sQjnHShM9YNoyZtIgByNNpUEtmQd2C0c
         vhdPlLxfHMRWt7X3Yqin4op/NhZxuFfJ3KLnV96uqbM4YTZayZmYKAk7CVzoXrE20p0X
         +6OER3foYqBX3wnaH7zRVyqcNDuYoNjrkKDU8XyT1UvLt++Li1O56QFltslBPEtTqD5z
         wgZKfXWPwZGvlKgBwIRKPv43oi8V97UBfjAMzOuYnaAq7AuPhJbmd2DIf02+IXElI5Nh
         Xv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721294748; x=1721899548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AQXyp5zTd9VUi1GRGHEcdKdd16XlM0Bs2GIA+qkJx8=;
        b=vschD+wTOyLaHr+aPBwO5Ae1703RYhzsKnytNpkoRO7nsSRGD6zsqWuXSCJWOFib/D
         GvdppWQHh0CwU6yCqFLLHWtR5Eu3ngrXefnJPBWsY4v75p3MKWqUcClKo2xHaGTCQxP3
         5MbzRSmzt33/CgTDQ8Uvke9BFgnDVdEpUsicoiptdgdUhciG3ksx/2OTU+JQHy6oUip+
         CkNHCzprHedyz8KOf3YIGC9ME6cCAupd82Qg10NsuPX4lfurNPXEWJ4qTFem8bBRIlTx
         mNsd1iuLsnnO4q2M7jpyCb6r/jViasJGOau0hMDEAri62Ebjaa0S2AOW6nstzEdm9GFj
         empg==
X-Forwarded-Encrypted: i=1; AJvYcCVWwCf5tLY3SSOI5kq5AbykfHN3D58ed0g4fSm2lpqHKW3T5N+S9eU4y/dP0sQTGXQsaFEZCyZVD63nIerLifUXUqO+D3Lu1w==
X-Gm-Message-State: AOJu0Yxzx2Wb4bc0KKguEBLodGRiT/oWy+TNRaKKokSjLnsmIqt8SYrP
	iEkouTkWIYTaKvwn6Ht3NvnzSr9buWH/D0q7MSgGLLVAjxEBnyNvm73Zi0VEbFg=
X-Google-Smtp-Source: AGHT+IFcIaqSCi+C+Us2/WOlLLOFk4vnRTB+ewPkaisAHCGngBiHg0I8w89X2OGpWh4lJCiAB53pmw==
X-Received: by 2002:a17:906:3b87:b0:a6f:593f:d336 with SMTP id a640c23a62f3a-a7a01138dd4mr273782966b.11.1721294747674;
        Thu, 18 Jul 2024 02:25:47 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff61bsm544875666b.166.2024.07.18.02.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 02:25:47 -0700 (PDT)
Date: Thu, 18 Jul 2024 11:25:46 +0200
From: Michal Hocko <mhocko@suse.com>
To: Qu Wenruo <wqu@suse.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Cgroups <cgroups@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
Message-ID: <ZpjfmlsikKCKWqOb@tiehlicka>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
 <Zpft2A_gzfAYBFfZ@tiehlicka>
 <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
 <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>
 <ZpjDeSrZ40El5ALW@tiehlicka>
 <304fdaa9-81d8-40ae-adde-d1e91b47b4c0@suse.com>
 <ZpjNuWpzH9NC5ni6@tiehlicka>
 <da00aadb-e686-4c47-80fe-cb26f928cf32@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da00aadb-e686-4c47-80fe-cb26f928cf32@suse.com>

On Thu 18-07-24 18:22:11, Qu Wenruo wrote:
> 
> 
> 在 2024/7/18 17:39, Michal Hocko 写道:
> > On Thu 18-07-24 17:27:05, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2024/7/18 16:55, Michal Hocko 写道:
> > > > On Thu 18-07-24 09:17:42, Vlastimil Babka (SUSE) wrote:
> > > > > On 7/18/24 12:38 AM, Qu Wenruo wrote:
> > > > [...]
> > > > > > Does the folio order has anything related to the problem or just a
> > > > > > higher order makes it more possible?
> > > > > 
> > > > > I didn't spot anything in the memcg charge path that would depend on the
> > > > > order directly, hm. Also what kernel version was showing these soft lockups?
> > > > 
> > > > Correct. Order just defines the number of charges to be reclaimed.
> > > > Unlike the page allocator path we do not have any specific requirements
> > > > on the memory to be released.
> > > 
> > > So I guess the higher folio order just brings more pressure to trigger the
> > > problem?
> > 
> > It increases the reclaim target (in number of pages to reclaim). That
> > might contribute but we are cond_resched-ing in shrink_node_memcgs and
> > also down the path in shrink_lruvec etc. So higher target shouldn't
> > cause soft lockups unless we have a bug there - e.g. not triggering any
> > of those paths with empty LRUs and looping somewhere. Not sure about
> > MGLRU state of things TBH.
> > > > > > And finally, even without the hang problem, does it make any sense to
> > > > > > skip all the possible memcg charge completely, either to reduce latency
> > > > > > or just to reduce GFP_NOFAIL usage, for those user inaccessible inodes?
> > > > 
> > > > Let me just add to the pile of questions. Who does own this memory?
> > > 
> > > A special inode inside btrfs, we call it btree_inode, which is not
> > > accessible out of the btrfs module, and its lifespan is the same as the
> > > mounted btrfs filesystem.
> > 
> > But the memory charge is attributed to the caller unless you tell
> > otherwise.
> 
> By the caller, did you mean the user space program who triggered the
> filesystem operations?

Yes, the current task while these operations are done.

[...]
> > So if this is really an internal use and you use a shared
> > infrastructure which expects the current task to be owner of the charged
> > memory then you need to wrap the initialization into set_active_memcg
> > scope.
> > 
> 
> And for root cgroup I guess it means we will have no memory limits or
> whatever, and filemap_add_folio() should always success (except real -ENOMEM
> situations or -EEXIST error btrfs would handle)?

Yes. try_charge will bypass charging altogether for root cgroup. You
will likely need to ifdef root_mem_cgroup usage by CONFIG_MEMCG.

-- 
Michal Hocko
SUSE Labs

