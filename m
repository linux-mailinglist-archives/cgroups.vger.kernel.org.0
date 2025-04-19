Return-Path: <cgroups+bounces-7652-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C581A94175
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 05:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E080819E3130
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 03:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8521413EFF3;
	Sat, 19 Apr 2025 03:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EZJEDGQ0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1651137C37
	for <cgroups@vger.kernel.org>; Sat, 19 Apr 2025 03:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745034068; cv=none; b=Fu1epG1RdeeS+ERK7O7+LsaWtXh7FzHBVuif31pznIVOHQ9FLOGON1pqTts90ALFSKMyULGNLYR0FmzHZnHMsQFnkHeqlDPn7LFCnRo6kLZfTbMdWy7lHL2ARbcEJEj+M/GoOS5gGp6YNPfQBA1P2qoolJdikndSrsaPi8elwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745034068; c=relaxed/simple;
	bh=PHdsXTX3X2tbXBA7ibrldPy1C6uFMyd0FcF6/SMQ3AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okRlJ21b64rTGkx9rlhN5PVkrgsTlo5JbU+sR0w7lSorOspP/KP2MfE4rCpWdIKhFrnQRfuMyMxnNwESRzcRQmtEAGmPbr/lBYxKcX7XVa+aXVl+9dMRPvo+MLsgQNwuwwwc6piNAnD1RtI+BeLWSKhxHk35/r+2RocPt8/uXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EZJEDGQ0; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c58974ed57so221949385a.2
        for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 20:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745034065; x=1745638865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vf/SdZzWZ/97U55NJCW7xj0E3zqMD/eAiVLqyHOwDFs=;
        b=EZJEDGQ0FmEbQ4lG28XHQFa7Z+5PvAWw2Foazq+K7DqaCDW1u1/k7dAdDMhYj00shn
         ljFyV+anvi8XNichPVN6tnDhwULLdTqqS4a7HEIJZElhmWaRx0uvbk/h7fFKGtYjT1hP
         PLi1IqCMF2NEH+RotV7pMTXl4iFlH+2B9OSh/6DayNhqnCziAlcDo+dB34q6iUkM23LO
         L8edvFpYeRiE6WlOWd18Ee2kbRYoIpAI8Tz4gIHX2O9vjwOOY9QqMWTg95DjfD+wwKfw
         7vzIEklhrL1BHebuW5unEjnEo5iTi2RxCjd/xaoEF9Sa0RUCR9tQXIt1oVjktlpLK9b9
         k9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745034065; x=1745638865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vf/SdZzWZ/97U55NJCW7xj0E3zqMD/eAiVLqyHOwDFs=;
        b=kfLVSqdCCGo9S3SlwWSChrOmzktxKaH//OhRMJLq3+bB2PxSvj/eemas/C5AJTXr6R
         Djkw91LxnPAfxwxtJw0PKcX4on4AX11FJVmiN/w6RYwPV7H9AEEbp4zyfRfT3NgRilbu
         W09k55A6MNfZZ3Esx+EcY667m27cRaa6AkntA00rieyFyo+aGvFr0Qh1LNo+zMvyzZDN
         KwtnZcl/JAE4ROJusbrnD9FZ70fRSZy8hnmZIdCc0/0XWLHrdEoPcgruT6+ZL3jKesTm
         4sM8ILW4HCF3nCyDw3BPEzN6KQpvPEW4khvROQBWfBRjuIAc39jRPNRiQ4fD/5uhPlVz
         UzBw==
X-Gm-Message-State: AOJu0YwnFVn3b+pzBq66M7SP76c+nDmVSPZ5ciefLmQoAh60I54YYab8
	Lsd8agklE0LG/wCKoeyq4+iJHx+ng12cQtwznLIy0ss2TcHoljdPJSgSo91Skk8=
X-Gm-Gg: ASbGnctGXxJI+IXarXoHJxdjBUyZTEDsFJKF1ApYbO/deQusf3WxhJk+SgmceN3WFCD
	M/UbqkDii6G4dkTi7dnF/XZZ5xqULSzy0XGvjPAG79nLnKakDk7JwBOoQW2veYenOPJby9AKgoI
	I0miFi8sK0bXefFlfKSSwdgA2e8s+jyqx99rjXwBkCh0WMH6h8Gb2tFhI/SWLGeowKDeouuZlF/
	CfpEtTOr3LwYXcya0HXbw8KIsHb2cItG6bpx9QEqpdHWtmasU1GRW0ezT2fPEz65GJyKUSTXH6H
	ThzvzZ6woGaBS8SkQcusMcCmNfeLudk6c+Ck8Af6h1kGXBLHP9zci4HpdFURZNw2p/lYUhnrDAp
	Brw7cZB7FRW0LQkY8lUMHwEY=
X-Google-Smtp-Source: AGHT+IHBuLN56lYhOyNk3hQZI/IKMdqmk7y+jZIExTVI9cAFyXEhsXltOxcEYmpfFoMh81jIo2Y7oQ==
X-Received: by 2002:a05:620a:260e:b0:7c5:94b2:99da with SMTP id af79cd13be357-7c927fb51f8mr786359885a.28.1745034065642;
        Fri, 18 Apr 2025 20:41:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c9280de4adsm152367485a.114.2025.04.18.20.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 20:41:05 -0700 (PDT)
Date: Fri, 18 Apr 2025 23:41:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	hannes@cmpxchg.org, mkoutny@suse.com, longman@redhat.com,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org
Subject: Re: [PATCH v2 2/2] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <aAMbT0Qh6yyrSJqt@gourry-fedora-PF4VCD3F>
References: <20250418031352.1277966-1-gourry@gourry.net>
 <20250418031352.1277966-2-gourry@gourry.net>
 <aAMTLKolO0GWCoMN@slm.duckdns.org>
 <aAMYOxSOrVpjhtzT@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAMYOxSOrVpjhtzT@gourry-fedora-PF4VCD3F>

On Fri, Apr 18, 2025 at 11:27:55PM -0400, Gregory Price wrote:
> On Fri, Apr 18, 2025 at 05:06:20PM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Thu, Apr 17, 2025 at 11:13:52PM -0400, Gregory Price wrote:
> > ...
> > > +static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> > > +{
> > > +	return memcg ? cgroup_node_allowed(memcg->css.cgroup, nid) : true;
> > > +}
> > > +
> > ...
> > > +bool cgroup_node_allowed(struct cgroup *cgroup, int nid)
> > > +{
> > > +	return cpuset_node_allowed(cgroup, nid);
> > > +}
> > ...
> > > +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> > > +{
> > 
> > What does the indirection through cgroup_node_allowed() add? Why not just
> > call cpuset directly?
> > 
> 
> This is an artifact of me trying to figure out how to get this to build
> with allconfig (matrix of CPUSET and MEM_CGROUP).
> 
... snip ...

Looking back through the include graph again

The reason was lack of inclusion of cpuset.h in memcontrol.c while
chasing the allconfig solution.

I was trying to following the current includes rather than making the
graph more complex - it wasn't clear to me whether going directly to
cpuset.h from memcontrol.c made sense - since memcontrol can be built
without cpuset.

The graph here is a head scratcher.  I'll still try a build with
cpuset.h included in memcontrol.c.

~Gregory

