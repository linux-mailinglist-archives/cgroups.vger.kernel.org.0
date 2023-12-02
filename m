Return-Path: <cgroups+bounces-776-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74174801B64
	for <lists+cgroups@lfdr.de>; Sat,  2 Dec 2023 09:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B0FB20DF9
	for <lists+cgroups@lfdr.de>; Sat,  2 Dec 2023 08:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875E9C2D8;
	Sat,  2 Dec 2023 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9gn3MhT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EECDD50
	for <cgroups@vger.kernel.org>; Sat,  2 Dec 2023 00:07:20 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6cdeb817ea6so2935939b3a.1
        for <cgroups@vger.kernel.org>; Sat, 02 Dec 2023 00:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701504440; x=1702109240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4H7ix0GwWOKnKT1fbRv5Z46mxtqVFyhAaxH7ZBfa1E=;
        b=O9gn3MhTdeau9nhpn+bsi6gmelfMzayHFqtWWoUuQYWWfruDNnZrLHSqInLvTLWDqe
         RSfEfu+nBxmkCDr4r8xCnBFnpc3qxySYwh775WA/xTX4/faYQPEN5WqWmzKsXAbdrWgA
         XeYwmacJQ3SthOXObxtoDFVG85zURy6YkqRY0hIEjoLUuxfUxMhCyXf4vpIXa0YV7N1x
         Ain19NBLZaSz7wkH8j01y3f7BquOitl/xKEGMgIw/+3kHa2syhEyZ7wThXVEoN2RH5lh
         f9LHUjtrivPfuP5+mWjy1t6ce2uQvJRKGo7e90g+cio3jiBZ5pJxFxNJkEstsrKi23rV
         OdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701504440; x=1702109240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4H7ix0GwWOKnKT1fbRv5Z46mxtqVFyhAaxH7ZBfa1E=;
        b=Yboaqkx3dVY7PfgvagF4z6MQJhfYBEx5AC8jay1GhA4+WYDzf5zpOwuBmA/FKi5MtA
         JjSnt7xMqw5/77vmr5WmL14tgguBvxftVKK8WnGK0QhF4k5Ahdp5yjGxKfxpoUyJD/l9
         HBpp/D/jifvWdIJiJ6nek1KqHK/+xLMSCnpRjpxFU9GMt+Q6sTyf1NGYS6AEzlDOPq53
         fk/C1TrnOJs4SuNxnayteYODc9oQgfaMIBwWgxXdVHcumGISovFozBCHzmqjG/yJesr5
         5gz/y3jhCM0glQnw/BVFNBVkdoGmCIJv/vQUSSKLUcOliluTTlOOa5+dyh4yUtwgTuBE
         eJ0g==
X-Gm-Message-State: AOJu0YyTkX6tzCrUB0JrdS9pbis9P0zI7yxe4zJtBwNj4qRbguNz2T+o
	A5sjDYz73PqF2M1eXanzcOUBoPYJQqyrHg==
X-Google-Smtp-Source: AGHT+IG2eYR6XCK75HIwvJKDXYxZCz40j886qrZkIZ8OMvd/IHm4nrH6JYuAPk74Uv56De/DVsgtHOrY69VO2A==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:902:f801:b0:1d0:5cf0:8ab6 with SMTP
 id ix1-20020a170902f80100b001d05cf08ab6mr356679plb.10.1701504439521; Sat, 02
 Dec 2023 00:07:19 -0800 (PST)
Date: Sat, 2 Dec 2023 08:07:17 +0000
In-Reply-To: <20231129032154.3710765-5-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com> <20231129032154.3710765-5-yosryahmed@google.com>
Message-ID: <20231202080717.ykhhu7fvryarphmi@google.com>
Subject: Re: [mm-unstable v4 4/5] mm: workingset: move the stats flush into workingset_test_recent()
From: Shakeel Butt <shakeelb@google.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, 
	"Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, 
	Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 29, 2023 at 03:21:52AM +0000, Yosry Ahmed wrote:
> The workingset code flushes the stats in workingset_refault() to get
> accurate stats of the eviction memcg. In preparation for more scoped
> flushed and passing the eviction memcg to the flush call, move the call
> to workingset_test_recent() where we have a pointer to the eviction
> memcg.
> 
> The flush call is sleepable, and cannot be made in an rcu read section.
> Hence, minimize the rcu read section by also moving it into
> workingset_test_recent(). Furthermore, instead of holding the rcu read
> lock throughout workingset_test_recent(), only hold it briefly to get a
> ref on the eviction memcg. This allows us to make the flush call after
> we get the eviction memcg.
> 
> As for workingset_refault(), nothing else there appears to be protected
> by rcu. The memcg of the faulted folio (which is not necessarily the
> same as the eviction memcg) is protected by the folio lock, which is
> held from all callsites. Add a VM_BUG_ON() to make sure this doesn't
> change from under us.
> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

