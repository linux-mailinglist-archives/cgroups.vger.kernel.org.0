Return-Path: <cgroups+bounces-7651-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E1CA94168
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 05:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6134606AA
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 03:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07C112CD88;
	Sat, 19 Apr 2025 03:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eCf7t4kQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E577DA9C
	for <cgroups@vger.kernel.org>; Sat, 19 Apr 2025 03:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745033280; cv=none; b=FYjQ9CrsWwShdhPICrMYQ4ZU3TDDr0wW6/DtK8baaqlfVBs3Fum4N6AvefqEmD4xVTFgGZGL3oC92dNpBl71VBvHNlTjJzcwC6Q7bi/8Ka6TRXteSGTJEwxsh5TiYBYDYYF/hOtFy9w24oT9v99lMHUsE8tgNCwu+Swq6lwUAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745033280; c=relaxed/simple;
	bh=EkdlhuUR/maeZPX8zcin25LaGkgfYCyCpyAOUj7+En0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQ5RRVP97ZRT7c/KBTmfs+n/6Lkb9u3++31qAAg2QN9FBqo7wObRBb3LIprOG0wgbIgCu1PLDY5khgmOzGaKXhW72fFiEXkN7N1sNf6WDMELEW1AAIotqw/3fRm1d5TkAsyQjUFfKaXabPXUFQMJfxPvgP/CKbaVDiBUvXiXiD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eCf7t4kQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c592764e54so290775285a.3
        for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 20:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745033278; x=1745638078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yeXMXSSzOYM79gde1X46jJHnJZxA7c7jB0TbcbsMRB4=;
        b=eCf7t4kQlccDo6yl4Nju9CImvydB+EzHmfZTpBWq67wmUuLhi1575mXROJ65FYweKx
         hPFSBlKK49S6fqj/6i5wS8SmQxURNgd1RMkyKaDoezf3qA3TguY9LrlWoLKcYpPx0WjZ
         IJXmd/sFNkkFLQdOZrB5UEMxszGS/+T+fuNkKbkST4E85Ugm/+XAvcfVJmMFVFX5oCg3
         k5OnXQ2b9hBfJlRp6o7n09ngcP7P+01bVzF8e9o7HCHrQTC/JnNKv7ITNyLfDF9JIq5U
         msgBuSOW3rI0SonHo9u/xsD+jSSm8IxQ88QMu62e9HAOug6wZLMyvo1BUqzdqNU/PVBN
         86Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745033278; x=1745638078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeXMXSSzOYM79gde1X46jJHnJZxA7c7jB0TbcbsMRB4=;
        b=oI2LT42teRneX9+ZdqJPrx5SU0AQatbrQXiaGKlr0J5vElLHjMNRNoWD/Fjh/ZwrcN
         0ScANRCSIPEyHXjlu6I6R34UGJDzhtFxgqNnB3ir6l3fsDMITrX66XDbej8Z4+K8bstx
         K4d/NA47UtLetp7bN2bdaJkIAdQGSMO98pLfr0q6i3Z4Mjo55DJMOGBKwY+9+ZCdfMIs
         SCN20flRh4LSISZfDP945SirpfcryYH2QajtXgSjJMVQNDs9iPHBJDzoiF6l3XuKgpNs
         0jgMqwfCBg+iVyCYo/ODIa/Qj6e9qT1xsPfmc+h5aRK9prtQhDIQT+LLMMnKCmKeiV06
         j/FQ==
X-Gm-Message-State: AOJu0Yw4U2Rb/n4NdfmiNCMlRHOX1G4UTFUCx5LHB6oj74ZDP+puPf33
	/4rjdKC3+capg1ySkYrl0GqBlnqRAX9r3Z7se4IwIH9GGpddj3sqfyciYgNLfvM=
X-Gm-Gg: ASbGncsS8Mj37aifMGEHJNqfBBsCxRf8BBtIWVpcH1XPrl+om0xRiupSyiZXWPnNDny
	xNbnMUccP+SbxT/JO92pvR/qXm3zKLQtluDUlUd8K4piz3fSESvad2axoxNgzSMq+bCYvcBNxx4
	NGOUZejh39t6zi+/ta+UAMZhr4k2xN+RmXdSZxRRactk9QSByyY7Ew5IdzWmDcOuxRdSLqzWbSQ
	DjlQQTBZyCJJc1bEp53VYawrkK4w4CP2/zfDTV+/zZIZx3Fl7b8xpS1CWPWeGWAq99Wpp/efD4S
	54n7I02ZOB6RT6b6qMYxzOQaYpHZWRCwk1lVBmDdT3rCFpeWeW/BD/Sv8Hu8D9+HpGrr9WJFwgr
	qOwa9aOlwF7ZYte8p2kvN5Mg=
X-Google-Smtp-Source: AGHT+IFI0fqsWNRil4RH53+meP9hxUVCCEQa8S74bFAShz56Lmc8QxXWWOZOtWwNV00SncAzpszxHg==
X-Received: by 2002:a05:620a:199e:b0:7c5:3ca5:58fb with SMTP id af79cd13be357-7c927f6fedfmr857572785a.4.1745033277742;
        Fri, 18 Apr 2025 20:27:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8f6d0sm174315185a.40.2025.04.18.20.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 20:27:57 -0700 (PDT)
Date: Fri, 18 Apr 2025 23:27:55 -0400
From: Gregory Price <gourry@gourry.net>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	hannes@cmpxchg.org, mkoutny@suse.com, longman@redhat.com,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org
Subject: Re: [PATCH v2 2/2] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <aAMYOxSOrVpjhtzT@gourry-fedora-PF4VCD3F>
References: <20250418031352.1277966-1-gourry@gourry.net>
 <20250418031352.1277966-2-gourry@gourry.net>
 <aAMTLKolO0GWCoMN@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAMTLKolO0GWCoMN@slm.duckdns.org>

On Fri, Apr 18, 2025 at 05:06:20PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Apr 17, 2025 at 11:13:52PM -0400, Gregory Price wrote:
> ...
> > +static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> > +{
> > +	return memcg ? cgroup_node_allowed(memcg->css.cgroup, nid) : true;
> > +}
> > +
> ...
> > +bool cgroup_node_allowed(struct cgroup *cgroup, int nid)
> > +{
> > +	return cpuset_node_allowed(cgroup, nid);
> > +}
> ...
> > +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> > +{
> 
> What does the indirection through cgroup_node_allowed() add? Why not just
> call cpuset directly?
> 

This is an artifact of me trying to figure out how to get this to build
with allconfig (matrix of CPUSET and MEM_CGROUP).

I think you're right, I can probably drop it.  I was trying to write :

bool cpuset_node_allowed(struct cpuset *cs, int nid);

and just couldn't do it, so eventually landed on passing the cgroup into
the cpuset function, which means I think I can drop the indirection now.

Will push it and see if allconfig builds.

Thanks

~Gregory

