Return-Path: <cgroups+bounces-4048-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68A59436C1
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 21:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971CA2840B4
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 19:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF75B14F125;
	Wed, 31 Jul 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q72fWqRe"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF63E45023
	for <cgroups@vger.kernel.org>; Wed, 31 Jul 2024 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455539; cv=none; b=BFPeoX5+Vs4OFuCdPmktpvlQr6arL0TnHnz5SYUsHAX7LwkolXf6m7wH+++L5O80ZOhm/busdBM8MzXs2RMI/G+a9qlslPnPrzOzg+oz4uYLQVCfdqtra/RqKuPAwq9RDOlXJ8ozuwiSEavDsnn4ByJpUZaDcM8oMSJwlqBzMfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455539; c=relaxed/simple;
	bh=5wKwM2WjspVaSSkYmcKPggPVFKPJi93u2e/t2OgWwDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=A4Xk+PHOorK4y3YnWZRCml0Laq/q4lgj9/iIMVDsQAkAJVp3PH8YH55wK4ZMXz6H+VlHDgGoFbIiILNKpkP2VgIoPxRvS35iQlRimHKTGFM5YoOG5hJcQjrksUKCN7q3mlmp/tmIKkFk/seWJ+HaSWtUAcygQVm3cWfDlyHTSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q72fWqRe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722455537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTZVFu7K6+uiaFa+bz2TYcCEINvR6BMH3QXaK+vFRmQ=;
	b=Q72fWqReiiq9ASr07l3aArPOm6bUywe28l1yagPUghj3DSDoeI6+p2lDQnwqk6p+0Lg44V
	EGm/nWMQ9FMaa4KhRvwozXALJu6YdFMwFhXju+4+j69MkOio30GVEVNBBVqFrSJ5XcN4kU
	ZokBjzpHGUOks6bZb+x4Bs6es0Vfkag=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-xVfPXJGZOtaIJrSQDvuqQQ-1; Wed, 31 Jul 2024 15:52:15 -0400
X-MC-Unique: xVfPXJGZOtaIJrSQDvuqQQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-79efb1181ddso647279485a.1
        for <cgroups@vger.kernel.org>; Wed, 31 Jul 2024 12:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722455535; x=1723060335;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTZVFu7K6+uiaFa+bz2TYcCEINvR6BMH3QXaK+vFRmQ=;
        b=guGJUU4BERsHeGwQ193g/9UgTqSY9i7MWf9bWc585iSBdEfDO8gC04rI3yfPWBfTt+
         TmEQAQ1iVWQlYelzXo03tbFXKrLb/4gRUz5Q0Pq9r0l6vNEl6z3MU22wTcSDBkziUNsc
         iguE7YVO/DY9LmPrQyfqLAv+ZF75lFIgiIAhsmNFN/L3eNF+IY1P3Ok+xz2eQiMO61dQ
         +VdsSxwl/NfubstPcC30Ns4Nbazp5gBvv+/+v9grnzLrQoiFejclnU7roFwn2zEbYk8X
         L5iF752Xc/erNMbcZxAvMVsWeKbBad/tiblujNAOQB9iM3e/nAPJPMj7EFXfPKaIwNpw
         SlDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMvmrd06gfK9vdDnq2atDP4NoA/+fEpKBfS+xZms69Gjhi88k8TD+lFQkSk7jTdtH5L2oCU0nsnsKL4oYtbuBIxjaJJtYbsw==
X-Gm-Message-State: AOJu0YyxKWOA9hEcp9b19mf1bmGxzf4isWOexP1rGzxOBa1SJcpwiAnZ
	oi4boFcvnMnIFwpNCQmF5X3cw77wTlssCRPRfmUWzH7RPDbzvo7TBu9jURaoniRp5Px+ZdpARtW
	mtufwFntW1daqSvBZ3w62r33uDD+IcELiNkMYbF/5cLUDrO+FwymX7qE=
X-Received: by 2002:a05:620a:4109:b0:79f:b0e:2e70 with SMTP id af79cd13be357-7a30c6e268bmr27103185a.55.1722455535063;
        Wed, 31 Jul 2024 12:52:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzhuQ/z0VlR0lBY46ZsSRSDGD9PSMp9Yhs26uV9BPy+b5xNpe/oJVl9BHdbGlhD4R9L+KWtw==
X-Received: by 2002:a05:620a:4109:b0:79f:b0e:2e70 with SMTP id af79cd13be357-7a30c6e268bmr27100085a.55.1722455534705;
        Wed, 31 Jul 2024 12:52:14 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a803:da7:cfdf:ab65:d193:5573])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1f89bf270sm310411285a.92.2024.07.31.12.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:52:14 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Leonardo Bras <leobras@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	anna-maria@linutronix.de,
	bristot@redhat.com,
	bsegall@google.com,
	cgroups@vger.kernel.org,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gregkh@linuxfoundation.org,
	hannes@cmpxchg.org,
	imran.f.khan@oracle.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	lizefan.x@bytedance.com,
	longman@redhat.com,
	mgorman@suse.de,
	mingo@redhat.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	rafael@kernel.org,
	riel@surriel.com,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	tj@kernel.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH 2/6] sched/topology: optimize topology_span_sane()
Date: Wed, 31 Jul 2024 16:52:05 -0300
Message-ID: <ZqqV5OxZPHUgjhag@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <9fb7adfc-701b-427c-a08e-a007e3159601@wanadoo.fr>
References: <20240513220146.1461457-1-yury.norov@gmail.com> <20240513220146.1461457-3-yury.norov@gmail.com> <9fb7adfc-701b-427c-a08e-a007e3159601@wanadoo.fr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, May 14, 2024 at 10:53:00PM +0200, Christophe JAILLET wrote:
> Le 14/05/2024 à 00:01, Yury Norov a écrit :
> > The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
> > even though cpu != i. In such case, cpumask_equal() would always return
> > true, and we can proceed to the next CPU immediately.
> > 
> > Signed-off-by: Yury Norov <yury.norov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >   kernel/sched/topology.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 99ea5986038c..eb9eb17b0efa 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2360,7 +2360,7 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
> >   	 * breaks the linking done for an earlier span.
> >   	 */
> >   	for_each_cpu(i, cpu_map) {
> > -		if (i == cpu)
> > +		if (i == cpu || tl->mask(cpu) == tl->mask(i))
> >   			continue;
> >   		/*
> >   		 * We should 'and' all those masks with 'cpu_map' to exactly
> 
> Hi,
> 
> does it make sense to pre-compute tl->mask(cpu) outside the for_each_cpu()?

Looks like a good idea to me.

Leo 

> 
> CJ
> 


