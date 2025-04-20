Return-Path: <cgroups+bounces-7676-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA6EA94A03
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 01:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367533A7FF5
	for <lists+cgroups@lfdr.de>; Sun, 20 Apr 2025 23:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203761E00B4;
	Sun, 20 Apr 2025 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bxS2JGdk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206111C1F22
	for <cgroups@vger.kernel.org>; Sun, 20 Apr 2025 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745193550; cv=none; b=grB88JYiUmcUUoW6wdlhHhuRuZCJNT60mlgaoX2wh6UwitaxblYNMuRIV+n5UhmKaWtp/AgbXqP3/3s8QYRwBjLS/khL/Y4rjNTruUyEx++VTmqf5TuJT+XA6X1yp8AGROx9Mpy9SjQEPd/3/Ei5b1vdZvPYJ23ksVU2HigzDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745193550; c=relaxed/simple;
	bh=uvrU5+6s0N5cLHmxcMFQr453iUMpwlwi2e09+0hsKu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qz6cydVf3gV7tAdGwjVyYFctpv3s03GREK/HrdPsBmuVJgKVaMACW2gwImkZEoV2UyOAxsGRzeuy9D6AxfYkHA7B4FeW832A8+8MIDVhXiynRIuAUtn6xECnrG/QXBBMNt/nDXZ3MSpfyYUbQavkm//PBhlkSkcg6xz9yl2tOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bxS2JGdk; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c7913bab2cso346047585a.0
        for <cgroups@vger.kernel.org>; Sun, 20 Apr 2025 16:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745193548; x=1745798348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mQesHxfKtuc73XSj9cqVrV4U7M1K9OzNneDiyDjZ40=;
        b=bxS2JGdkJ9fxp1wsP8YncJl4qTwrJ4IoD0W4tDPCgXswbjoXgyw+iW6+fX1E6E//yu
         fzLra0/qSF63cvXCg4JrhxW5s1JtpV4IJ6kyud0x8JN9qgOYAORVjiWtMwIQHKYY57/3
         jih7sZYpniZnFwzJE0mIANXDc+jJYAD54MWUw4zx4D6wLkXBtcyE/IYKCk/vHb25yNwG
         CTLGxdHJtTCqGXEonjRBq8eonUC2Stxd9+pqvQKAfOycvA+19rorS2+/vTq2xWwTSrja
         gw5Uw+zxGMSj/emtoCPLVtWj4ItNbdYa31HfHhKQ6bOo7qjIDc+bq/6aWRk/w1YmaY10
         Cq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745193548; x=1745798348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mQesHxfKtuc73XSj9cqVrV4U7M1K9OzNneDiyDjZ40=;
        b=N3FEtxwS2mLPUH999ajrcsH7BOfoSUKHZi8hp6sR9uLT2oy9J9PB+nY3rnEj9AJ3UX
         Qj/K/ihK9MqVHAQ2kRI65j4qM5nW6UJcRkZFnBuPvCxMS6Pnr7dYiUjzYblZx/mohc0I
         m9BEfa0CoDUYcQylCs1bX/4qZcWcv6C7seCxOIyn8Bl7snyqsKMF8DDFCToegvnxXQae
         SMh1R78Nn8fWm5HUnxTGMspEVdr1zoHlzfnUykhq4U8cB+ox7iq2BoHjZZB+pDP5qqt4
         2yoHB2vJUS9/mGw0uhmoKgRXj27+VTEhCj29p3iEgH12jXyCCuBBb2YgBnja70gDhvTC
         8neQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcK6GlMtCO5CXUNHmBSh48whfhCjtj4tFlrI7babZWAqeyO/5zTplC30JGgvlwdaM7bhYkWqAK@vger.kernel.org
X-Gm-Message-State: AOJu0YyD8lFkhLMgSga631/KZr2oWwB9+IzCx4Unz/UNeG/MzPTaO/eS
	+tEM/KeHUWjIxfHpPe/GnAebxQEAL9Mc8gXcoz4+a8XHMVcOp+rhU0CZxl8e0ug=
X-Gm-Gg: ASbGnctqNlAu3YNjtNiI9qzrRRSe1qA0KRluCDdxt3w0YB0Apumo6B6kAyPFpuwL6/Q
	QCn1asC7YOri0CCNu8eybyh7kpQnW+Yg5Mvti/BznhXUk5EHqmcdSWd6qVBqbk1vGexhlMnH9bX
	SXr0uUZITxWotBhEjaI91k0HnB6V0D7D62GXKMawAHBBxK4tNe1oKODqQgpHSgJYtHNsWusmjjP
	wL4srqDC7oWrcR2Fz4CFtqVTXDQOkFVmI2WS3wgumtKwiWmii27F97mWkcmgzrI3YabSN0cKw+P
	ymNNJJ1SyIQKMasiAhKaEZxgODdMqTNQv9jC2IJBY5C14F06Np8Xvp0jZXt7C90TVGdvGs9uV9y
	+B3EXsdPr4HX0oqdrFtTyISlaxz95IP9S4A==
X-Google-Smtp-Source: AGHT+IFhH1nWHcHOiEwOCjwti40tQB4MIiy3rrP4y16J3QXDbzb5k/8Z8Mai0D7KL4gpGcXFnHhTVw==
X-Received: by 2002:a05:6214:2483:b0:6e6:65a6:79a4 with SMTP id 6a1803df08f44-6f2c468812dmr184751696d6.44.1745193547812;
        Sun, 20 Apr 2025 16:59:07 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b3274csm37135666d6.58.2025.04.20.16.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 16:59:07 -0700 (PDT)
Date: Sun, 20 Apr 2025 19:59:04 -0400
From: Gregory Price <gourry@gourry.net>
To: Waiman Long <llong@redhat.com>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org,
	mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3 2/2] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <aAWKSGsWHipFfi1l@gourry-fedora-PF4VCD3F>
References: <20250419053824.1601470-1-gourry@gourry.net>
 <20250419053824.1601470-3-gourry@gourry.net>
 <532fe761-4907-4f4b-b98d-566453301399@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <532fe761-4907-4f4b-b98d-566453301399@redhat.com>

On Sat, Apr 19, 2025 at 08:31:41PM -0400, Waiman Long wrote:
> On 4/19/25 1:38 AM, Gregory Price wrote:
> > diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> > index 893a4c340d48..c64b4a174456 100644
> > --- a/include/linux/cpuset.h
> > +++ b/include/linux/cpuset.h
> > @@ -171,6 +171,7 @@ static inline void set_mems_allowed(nodemask_t nodemask)
> >   	task_unlock(current);
> >   }
> > +extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
> >   #else /* !CONFIG_CPUSETS */
> >   static inline bool cpusets_enabled(void) { return false; }
> > @@ -282,6 +283,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
> >   	return false;
> >   }
> > +static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> > +{
> > +	return false;
> > +}
> >   #endif /* !CONFIG_CPUSETS */
> 
> I suppose we should return true in the !CONFIG_CPUSETS case.
> 
> Other than that, the patch looks good to me.
> 

Woop, quite right, thanks.

I'll v4 and hopefully get some -mm feedback

~Gregory

