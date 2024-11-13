Return-Path: <cgroups+bounces-5542-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC929C7AC8
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 19:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270B228AFC5
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D260B204010;
	Wed, 13 Nov 2024 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMYkdEoV"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B5204014
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521481; cv=none; b=OJJKVLTINCued8zY9YKoqI58uc2W4DWq7Iwf8LfUNTy8dwVtRF6y7iVRqbwLKKeDJAPDRTRyAp/KvPVGV7XhNKpC7itK1oM1iDwSL8rtjNQBNLkerp1yeVMjZQXrSHWy0Rf0SMs/1P3lXKDUWWriQBfVrkccC8y/UVRXdlffPbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521481; c=relaxed/simple;
	bh=GfyaBzsQaxbrDn9GkteBDYEIG6fY5LTY2BMi1OO6/hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvWcJH7uTAo8ylHem5HEXRTjTdhFNSmRtHcsW4LnvsA6F9qp7DtSagn02Paob8vjfkUeQjc2NG8aX69epVAGKn1legKO1xAtOleJlISDv4ecqGx3c+btbXwQJ2pz/uV3gX8yys7WfbJ8s4zQtIAIAWXwc3UNpjvNZceiVrZd0Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMYkdEoV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731521478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VewxfuCQAz2e8hyqcp+K3zDr+wxn5nG+1x8oL8KmYr8=;
	b=OMYkdEoVkFgB4Wub+d0Mz3aO7f07/SAIR6zgu+o6C/Q0AgagnNOnTul939ylYrrLXE9V/u
	aIQPQ+IyIImU95tKw9AcWy01S+gTXALfov+VLj8uUMmKChDll9QwzEFyKGZFhXzIgOgCdI
	c1HCtbDmgwPNrvz2apUWWtFOKMz/rVE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-u4FeN7FgMeSOkFqX48jR-Q-1; Wed, 13 Nov 2024 13:11:17 -0500
X-MC-Unique: u4FeN7FgMeSOkFqX48jR-Q-1
X-Mimecast-MFC-AGG-ID: u4FeN7FgMeSOkFqX48jR-Q
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d458087c0so655920f8f.1
        for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 10:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731521476; x=1732126276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VewxfuCQAz2e8hyqcp+K3zDr+wxn5nG+1x8oL8KmYr8=;
        b=tm6gB9qm7gEcJGHdirYU8xlwCMlBV9w9UgI10CgIstFsvfedzbV2++8CVWxYJ+/ZEh
         zQHdE+EqYnFjnXWcVaba8O9bfzpQIlnGgIq8pfmZANot7TFAOIitfe/iiqkZ4Plz/50s
         CTxcuwu1wKaoEBZZP4X0Tp20zlAxXl2sxOrqGA2VwFYAuoj6DRTtBJ7tW5qJi5THhhQ1
         i4V8IhXuaUhBjCCPNPiV368GrjRuEj+Uytfe5AOyoTwpb5Qo+ulrzBjPGBU/DTpSq5D/
         SSuyI7sbSZrYokiju0/DFATEr+ZROiAp2kRJWlYCvIJFWEn3tAkx2p6I6Y4YqgDv/4oq
         mLYw==
X-Forwarded-Encrypted: i=1; AJvYcCVTAxDNUC58Mfd7XNgTX1HvTUfgQb8N1HYbEyf6S+POPhU15JQvn8KCNvA9yhL0pRUUKOysLIjb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn2Fu+mWagJIQLf6fl6WRm5AQ48UlhsZtZCJUg2JIyCSg644eg
	jgQ3aOU+J5oR57rZTshiU6yTX1SSmO/Vaa3H1WUuA0kovivc3UgqGYyZPfq/cYfvM+LIR/QFtpf
	o/7N+aEHkDqQINxLYMToiwlcDT7j/6nemsKKSiwE1WbGxMNoSmoI/A9Y=
X-Received: by 2002:a5d:6482:0:b0:381:f596:767a with SMTP id ffacd0b85a97d-38213fffc48mr308239f8f.12.1731521476254;
        Wed, 13 Nov 2024 10:11:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGF8uZppBytmLF63T+fKBgKHNNYYjeLf5PwMN7OvReEObKbV3FfIPXk02/SLRoUJgOqSKX8ug==
X-Received: by 2002:a5d:6482:0:b0:381:f596:767a with SMTP id ffacd0b85a97d-38213fffc48mr308206f8f.12.1731521475819;
        Wed, 13 Nov 2024 10:11:15 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97e46bsm18730859f8f.30.2024.11.13.10.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:11:14 -0800 (PST)
Date: Wed, 13 Nov 2024 18:11:12 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/deadline: Correctly account for allocated
 bandwidth during hotplug
Message-ID: <ZzTrwJoTetlt2Anj@jlelli-thinkpadt14gen4.remote.csb>
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-3-juri.lelli@redhat.com>
 <8e55c640-c931-4b9c-a501-c5b0a654a420@redhat.com>
 <ZzTWkZJktDMlwQEW@jlelli-thinkpadt14gen4.remote.csb>
 <b7c75f06-1ab5-48c4-b2fb-521508f20f9b@redhat.com>
 <c30adf62-3012-46fe-ae52-2f6de1e20718@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c30adf62-3012-46fe-ae52-2f6de1e20718@redhat.com>

On 13/11/24 11:50, Waiman Long wrote:
> 
> On 11/13/24 11:42 AM, Waiman Long wrote:
> > 
> > On 11/13/24 11:40 AM, Juri Lelli wrote:
> > > On 13/11/24 11:06, Waiman Long wrote:
> > > 
> > > ...
> > > 
> > > > This part can still cause a failure in one of test cases in my cpuset
> > > > partition test script. In this particular case, the CPU to be
> > > > offlined is an
> > > > isolated CPU with scheduling disabled. As a result, total_bw is
> > > > 0 and the
> > > > __dl_overflow() test failed. Is there a way to skip the
> > > > __dl_overflow() test
> > > > for isolated CPUs? Can we use a null total_bw as a proxy for that?
> > > Can you please share the repro script? Would like to check locally what
> > > is going on.
> > 
> > Just run tools/testing/selftests/cgroup/test_cpuset_prs.sh.
> 
> The failing test is
> 
>         # Remote partition offline tests
>         " C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 .   0
> A1:0-1,A2:1,A3:3 A1:P0,A3:P2 2-3"
> 
> You can remove all the previous lines in the TEST_MATRIX to get to failed
> test case immediately eliminating unnecessary noise in your testing.

So, IIUC this test is doing the following

# echo +cpuset >cgroup/cgroup.subtree_control
# mkdir cgroup/A1
# echo 0-3 >cgroup/A1/cpuset.cpus
# echo +cpuset >cgroup/A1/cgroup.subtree_control
# mkdir cgroup/A1/A2
# echo 1-3 >cgroup/A1/A2/cpuset.cpus
# echo +cpuset >cgroup/A1/A2/cgroup.subtree_control
# mkdir cgroup/A1/A2/A3
# echo 2-3 >cgroup/A1/A2/A3/cpuset.cpus
# echo 2-3 >cgroup/A1/cpuset.cpus.exclusive
# echo 2-3 >cgroup/A1/A2/cpuset.cpus.exclusive
# echo 2-3 >cgroup/A1/A2/A3/cpuset.cpus.exclusive
# echo isolated >cgroup/A1/A2/A3/cpuset.cpus.partition

With the last command, we get to one root domain with span: 0-1,4-7 (in
my setup with 8 CPUs) and no root domain for 2,3, since they are
isolated.

The test then tries to hotplug CPU 2, but fails to do so and so the
reported error.

total_bw for CPU 2 and CPU 3 is indeed 0, and I guess we could special
case this as you suggest (nothing to really worry about if we don't have
DEADLINE tasks affined to these CPUs). But I would have expected the
fair server contribution to still show up in total_bw, so this is
something a need to check.

Thanks,
Juri


