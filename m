Return-Path: <cgroups+bounces-12149-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA10C778F1
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 07:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1B85357A7B
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 06:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E5C313552;
	Fri, 21 Nov 2025 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UqE8m3cM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949D3126AF
	for <cgroups@vger.kernel.org>; Fri, 21 Nov 2025 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706082; cv=none; b=LqpY3+tqm6UT5vPvURB22Y1oBYuw2rN0UHtthFHWJYYRmQ5ZbffAJCyWVtkfDzRTK/OFP772+UGZKPN56TqUBIHvKqJF1IDvuQMi4LiTzoVUqSglKy+SBr+T9M2lbMf4csBLZxzbGd558dmY6zmLSsseuLcjK6CW7wIKCq8JdrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706082; c=relaxed/simple;
	bh=6/KAdvvrjr/T72RBsaCa+aRGZQh2dD1B7gOvePh8j1w=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=KvFQMetUDz7IBSeauSAVh21cYNhuBxkcMMr79cu5awuCPXrS3gXMyABQTWBL0ROYVyUl7BBK9NzlpLM98Miph0Lv/T+JDYiOGtUDXnf7APBYreJkMHPoNSOXqAtLnS8vtXB0iothhhKPtYY6dchBrCvwTr5YjG1DRBSQgmRzFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UqE8m3cM; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763706067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6UFvv5WSTFiEuW2DwdA6m8neMzcRc9pSuFfXqWd3P0=;
	b=UqE8m3cMbIeG4MhOa2GxyTW4X1lFdNgrDYhk6RtY1QQvYAdzn4vephRqJRIKzkbK6o2tTD
	rnCQeubE/k8aBI3kisBfLB0DVklJtlJP4bRRtyLaxxytbza9k3ET1pL7LAIh61jaP5vua2
	TCRICAIXkLKFQewPG/yb8CfMO2KLr6g=
Date: Fri, 21 Nov 2025 06:21:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <305559b6e8249a31ccbe1fe77fd3a3c041872c4b@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] cgroup: Add preemption protection to
 css_rstat_updated()
To: "Waiman Long" <llong@redhat.com>, cgroups@vger.kernel.org
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org
In-Reply-To: <6cd2dc59-e647-411f-ba3e-2a741487abb8@redhat.com>
References: <20251121040655.89584-1-jiayuan.chen@linux.dev>
 <6cd2dc59-e647-411f-ba3e-2a741487abb8@redhat.com>
X-Migadu-Flow: FLOW_OUT

November 21, 2025 at 13:07, "Waiman Long" <llong@redhat.com mailto:llong@=
redhat.com?to=3D%22Waiman%20Long%22%20%3Cllong%40redhat.com%3E > wrote:


>=20
>=20On 11/20/25 11:06 PM, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> BPF programs do not disable preemption, they only disable migration=
.
> >  Therefore, when running the cgroup_hierarchical_stats selftest, a
> >  warning [1] is generated.
> >=20
>=20>  The css_rstat_updated() function is lockless and reentrant. Howeve=
r,
> >  as Tejun pointed out [2], preemption-related considerations need to
> >  be considered. Since css_rstat_updated() can be called from BPF wher=
e
> >  preemption is not disabled by its framework and it has already been
> >  exposed as a kfunc to BPF programs, introducing a new kfunc like bpf=
_xx
> >  will break existing uses. Thus, we directly make css_rstat_updated()
> >  preempt-safe here.
> >=20
>=20My understand of Tejun's comment is to add bpf_preempt_disable() and =
bpf_preempt_enable() calls around the css_rstat_updated() call in the bpf=
 program defined in tools/testing/selftests/bpf/prog_tests/cgroup_hierarc=
hical_stats.c instead of adding that in the css_rstat_updated() function =
itself. But I may be wrong.
>=20
>=20Cheers, Longman
>

If that's really the case, then I'd rather add a new wrapper kfunc for BP=
F
to replace css_rstat_updated(). Otherwise, whether it gets triggered woul=
d
depend entirely on users behavior.

Right now, this WARNING is showing up in all BPF selftests. Although it's=
 not
treated as an error that fails the tests,it's visible in the action runs:
https://github.com/kernel-patches/bpf/actions

