Return-Path: <cgroups+bounces-533-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD877F59DA
	for <lists+cgroups@lfdr.de>; Thu, 23 Nov 2023 09:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F321F20CCA
	for <lists+cgroups@lfdr.de>; Thu, 23 Nov 2023 08:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2086A1944A;
	Thu, 23 Nov 2023 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x2rkB6ud"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7524B1B2
	for <cgroups@vger.kernel.org>; Thu, 23 Nov 2023 00:15:50 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6c4d0b51c7fso700788b3a.2
        for <cgroups@vger.kernel.org>; Thu, 23 Nov 2023 00:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700727350; x=1701332150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CrEIDOduhti6InSDnRypg+BVJxqG3xXbxgAmhP0hxmM=;
        b=x2rkB6udHXM79Gx1VkF6RrzD0tkl8Be5FgtE3leLVPPPHRlc3EdNlXYMpWS1WCQu15
         jpB9m/m1cj39LXqICa4WRPMBzhRmRC7MdKehkFEZ6SKY+Cr21d0Ohza5FhK8wi1FRGbk
         MwSle3fAAhUf8CUlZE5QA3qedYhd9XPLO7ebvQllVBP670LRNX2qrCXm94laDm3nVw+W
         SFnTAd/1AYN2Jr/Tr5yme7rKS6ARtt3VUC/3sNhFijq/dZomO18mOpRxQ/E+Th0vTpPH
         qJpY7AeLAVPnsYEJNmm3oh49t4jQj1w1hgwL4rT3aKTczffTP84nb03xP331TWGGfk/p
         ITbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700727350; x=1701332150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrEIDOduhti6InSDnRypg+BVJxqG3xXbxgAmhP0hxmM=;
        b=Hqt/XuHAzUk4GDA0RCn8BK5GmEaBcovYCNlYjN/hwh8H+IIF0Z32nPGJmd2WQsxbW1
         G5a9yfasPJzIoEUKxnEzWAKZlelQnO2wNB3YKAgTcLWFdiY9Cbscv+/tD6SGuGG2rv1O
         gmHTwvL+0Mvf9CQLE9ZmJOyub6kjX40rKNo1Hmnyz3PMO7TAt6wzTv400dynhcJV7H40
         FezJZQ1zX6BaYsd7/+Hg7C8OSvEnjIppuhlQdQp9fk4K+0YYUkvK1tOFX9YGyhfcNf54
         SP2kSJLFcWPqES24pSybGC9vh2BJfn7btzcjHloE2UxUrasPCAWEfJiqxnRYOpgMX780
         54YA==
X-Gm-Message-State: AOJu0YxAW22rTPbuOuhy1Nk7YmK9zsdzY5YDeSpTnlKrYs4lDul8SnJW
	eXz7PsG5T92PpXTRCy2xaJTY6+1b7U28NA==
X-Google-Smtp-Source: AGHT+IH9adT6B0i1q+P6CsoaxvjLgFLnosKLJplk4qIgLHNWoRCdaiFD4O87oq0Kh4mkVoq1iaj+K6sacIpqzQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6a00:1da3:b0:6c4:ec00:2941 with SMTP
 id z35-20020a056a001da300b006c4ec002941mr1201225pfw.4.1700727349918; Thu, 23
 Nov 2023 00:15:49 -0800 (PST)
Date: Thu, 23 Nov 2023 08:15:47 +0000
In-Reply-To: <20231123080334.5owfpg7zl4nzeh4t@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231122100156.6568-1-ddrokosov@salutedevices.com>
 <20231122100156.6568-2-ddrokosov@salutedevices.com> <20231123072126.jpukmc6rqmzckdw2@google.com>
 <20231123080334.5owfpg7zl4nzeh4t@CAB-WSD-L081021>
Message-ID: <20231123081547.7fbxd4ts3qohrioq@google.com>
Subject: Re: [PATCH v2 1/2] mm: memcg: print out cgroup name in the memcg tracepoints
From: Shakeel Butt <shakeelb@google.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	akpm@linux-foundation.org, kernel@sberdevices.ru, rockosov@gmail.com, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 23, 2023 at 11:03:34AM +0300, Dmitry Rokosov wrote:
[...]
> > > +		cgroup_name(memcg->css.cgroup,
> > > +			__entry->name,
> > > +			sizeof(__entry->name));
> > 
> > Any reason not to use cgroup_ino? cgroup_name may conflict and be
> > ambiguous.
> 
> I actually didn't consider it, as the cgroup name serves as a clear tag
> for filtering the appropriate cgroup in the entire trace file. However,
> you are correct that there might be conflicts with cgroup names.
> Therefore, it might be better to display both tags: ino and name. What
> do you think on this?
> 

I can see putting cgroup name can avoid pre or post processing, so
putting both are fine. Though keep in mind that cgroup_name acquires a
lock which may impact the applications running on the system.

