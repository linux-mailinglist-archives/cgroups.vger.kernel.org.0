Return-Path: <cgroups+bounces-5606-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A813E9D0BF1
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 10:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E8E1F20FE6
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 09:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7948186E46;
	Mon, 18 Nov 2024 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kgvzt5m6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1185152160
	for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922776; cv=none; b=oSsHZ5jGjh67Qk6JkuSvxc+9Ap87DW8Unq/kfYtpmY8lrSUgXAgZQCOoJewPcTdlbNR8sMirH5SoxhIn9b1i4xmb+WALhBkIJ/kHgWW/DF9LORKBdpNWDfHTRHi1M54tzsk8cmOK6hmvV/eWv5KC9GC68SuVMjPFHPTfsAg0zB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922776; c=relaxed/simple;
	bh=ASfy3ZmkJlDJivURpQuQX8Ww/zzWEUu+7CDd1iXeFdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgSxQT9sxraHbblvsaHCP5/CVka0/Gf4Ug67rmCV71+Y6SX0imE0zHBJRPYm2HYZxkThD1kaM+ErVi+u2R/fHUGLx7bCGZu4I4YbzkgaeBFTv6pxQqjMO5uH9tUlhDFU2jBRy+Xek859J5PdXNCYULOi+p8lUZfGa0qilK7woOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kgvzt5m6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731922773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SCTWIW9+3Ez/dT5JWYg8kZzlPGcdYEYTLifRWAR2waM=;
	b=Kgvzt5m6jb7OenCKB2hRv4kZZaQtn3YHYPY1AYXv9wxhCUW2a+FyIh5fr/EVrP/C1AceRp
	nNA4m4z3mvnMMZTJwwntnYlp8H7lV4MiRizFdP0/eRyzPJ4zP4HVwk5sqjh1eRwhQed5Uk
	24wYX+Z6eScxHUNCNq8vGRJc6YwtPAo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-_ibd_1j0Oz2b1ewnTT9O-g-1; Mon, 18 Nov 2024 04:39:32 -0500
X-MC-Unique: _ibd_1j0Oz2b1ewnTT9O-g-1
X-Mimecast-MFC-AGG-ID: _ibd_1j0Oz2b1ewnTT9O-g
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315dd8fe7fso18157915e9.3
        for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 01:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731922771; x=1732527571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCTWIW9+3Ez/dT5JWYg8kZzlPGcdYEYTLifRWAR2waM=;
        b=rAxAl5NN909zLRI1Klf1K7e6jaDhr86ry/nmXwxxsL4MMKXsRCkBQE11AEE7OKvj+f
         8AqA3OKDAiho6cvvaxGhQqKplZ/CJxqd0q1HEhv8hxLyDpMGOMCIFOrz6sz3doUpXqdm
         v2g5ZiuA4/46ulS2mcuf5Pg+KdWffQNBJcxL+MgWCJYEe1N/MXeQlk85kbUbg55a+VIa
         /fvo28u6xg2u2beiGPaA4LfnuoLKIxn1ELnhMU7a25tnqj/fZRQjbkL0g40jBi1ro1aI
         kO1CSa/82bNOFviDeVjAaDVTtdsp1vc/NZ+Y7udTOyVDMYq1oYNZyya3RVQEN3bJgoCQ
         WeEg==
X-Forwarded-Encrypted: i=1; AJvYcCXBpf5ddO8iBhNInW7aLmDkHGtUqJ2JuPzlbpMC7yrjOmrjRin5Pv4kQKp7q1dfHaUPwXnE8qPV@vger.kernel.org
X-Gm-Message-State: AOJu0YwyTKLzjvXUFwOGrqusTFs2y0i7gVNlagL3xlWYyFBpAfsJIxem
	NxcHjn2mX9CNjz8W6wLPOtmp6bOWcwj3e12M3fSbHvserU+3J9PfGvqoZ9kDEfKA6yEqdIKUuM+
	491dxIsGEqQXqqbF4rxKDCxdaZYAcJi9AFoibyVTy2YWf7Vd6Gm+bTbE=
X-Received: by 2002:a05:600c:34d0:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-432df7229f6mr121513835e9.6.1731922769573;
        Mon, 18 Nov 2024 01:39:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc6yVpDr/TaAuyJ9tO0NDlNPWZ/GE7BRdiwq0stPKiYiB6rMVLY2MnHX6hc4DRwRnWcOGDEA==
X-Received: by 2002:a05:600c:34d0:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-432df7229f6mr121512985e9.6.1731922767768;
        Mon, 18 Nov 2024 01:39:27 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.74.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab807d4sm148437785e9.21.2024.11.18.01.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 01:39:26 -0800 (PST)
Date: Mon, 18 Nov 2024 10:39:24 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH] cgroup/cpuset: Disable cpuset_cpumask_can_shrink() test
 if not load balancing
Message-ID: <ZzsLTLEAPMljtaIK@jlelli-thinkpadt14gen4.remote.csb>
References: <20241114181915.142894-1-longman@redhat.com>
 <ZzcoZj90XeYj3TzG@jlelli-thinkpadt14gen4.remote.csb>
 <1515c439-32ef-4aee-9f69-c5af1fca79e3@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515c439-32ef-4aee-9f69-c5af1fca79e3@redhat.com>

On 15/11/24 12:55, Waiman Long wrote:
> On 11/15/24 5:54 AM, Juri Lelli wrote:
> > Hi Waiman,
> > 
> > On 14/11/24 13:19, Waiman Long wrote:
> > > With some recent proposed changes [1] in the deadline server code,
> > > it has caused a test failure in test_cpuset_prs.sh when a change
> > > is being made to an isolated partition. This is due to failing
> > > the cpuset_cpumask_can_shrink() check for SCHED_DEADLINE tasks at
> > > validate_change().
> > What sort of change is being made to that isolated partition? Which test
> > is failing from the test_cpuset_prs.sh collection? Asking because I now
> > see "All tests PASSED" running that locally (with all my 3 patches on
> > top of cgroup/for-6.13 w/o this last patch from you).
> 
> The failing test isn't an isolated partition. The actual test failure is
> 
> Test TEST_MATRIX[62] failed result check!
> C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 . . X5 . . 0 A1:0-4,A2:1-4,A3:2-4
> A1:P0,A2:P-2,A3:P-1
> 
> In this particular case, cgroup A3 has the following setting before the X5
> operation.
> 
> A1/A2/A3/cpuset.cpus: 2-4
> A1/A2/A3/cpuset.cpus.exclusive: 4
> A1/A2/A3/cpuset.cpus.effective: 4
> A1/A2/A3/cpuset.cpus.exclusive.effective: 4
> A1/A2/A3/cpuset.cpus.partition: root

Right, and is this problematic already?

Then the test, I believe, does

# echo 5 >cgroup/A1/A2/cpuset.cpus.exclusive

and that goes through and makes the setup invalid - root domain reconf
and the following

# cat cgroup/A1/cpuset.cpus.partition
member
# cat cgroup/A1/A2/cpuset.cpus.partition
isolated invalid (Parent is not a partition root)
# cat cgroup/A1/A2/A3/cpuset.cpus.partition
root invalid (Parent is an invalid partition root)

Is this what shouldn't happen?


