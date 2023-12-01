Return-Path: <cgroups+bounces-766-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF088011D5
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 18:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14DD1C20AC2
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 17:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436F14E1CE;
	Fri,  1 Dec 2023 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWrsDN6b"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF06EFE;
	Fri,  1 Dec 2023 09:37:51 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce015fd299so787611b3a.2;
        Fri, 01 Dec 2023 09:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701452271; x=1702057071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1vqngejylljTl8aS0wEyCo9hvaRqIL121iZk7bSTek=;
        b=BWrsDN6bFv6dEdWNbX2GjqRojrgzaLAnTM84pTfad/jJBGwDaB9pMTdb6xm4iuynR6
         Ki3kPHZdHhgyk6dZWIuKBMOIUUMFKRNhlzFs+kHv8cgrMS6DM4vtCJOQyx7VGk4RDQai
         6zFy+hZV8kWc7frhzCGmAD/SaqLNh7dq4OilINsQaZsi1Ja8pVMYNGJIDqoBpQnRkBPh
         H7MKk+In6in1vDVrlPLH51M0ybdUInLiXMG8ls13eh83IIuMtA+UHq/e5Ql0NhSX8/jF
         dKCjmRldX5OuOqEJ0nB3peICZp/jPGbxAXXCz75SqUvgvk/HezYHccw1gh1KmziX/IuP
         lmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452271; x=1702057071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1vqngejylljTl8aS0wEyCo9hvaRqIL121iZk7bSTek=;
        b=aPlJBh0ewahY/3M99Q5aG4KeDepU/FMh55jHEWWMYewXKRpPaWnaDEVW2fR4VJWeG0
         24QhFEoy/9q+//nQ67O0KmpsfXDP7bi4N1xP4O/pxpQOGCkVmGeFGKFRiw0rDTdaOD+e
         2QHFAlQT8Emc0zowvf9BccDlqPTB3tRfQPPy+rGyehHEmYJRsgO4zomoGw16jDne/yuR
         bx0+GWn7c2522+EWcPe6HlixsCSdBziwMg9yS9J2I4FXZAZbaa6TCj6jyDZrVu5jWy4O
         gZowecFZTWILkwx1eOPKZOlPA+kmX7QjclfA0efL1YLtmeK2GGfpx3kzyAyce1tMYC3/
         ElwA==
X-Gm-Message-State: AOJu0YxcHxQZ7q3TsE82JzL5Gd4HB4vh0FGIUcBCPSye8SKoSZU1rpOn
	X/0N3usnfRiVaBrjxNlKPLw=
X-Google-Smtp-Source: AGHT+IFAt0LiS7l0sn2Vw/b/IlTmAaaNeqgD2j10o5eTcjXrQnLBJ5810dswT4esP2xu+ZTLejLRGA==
X-Received: by 2002:a05:6a20:914a:b0:18c:651:c40e with SMTP id x10-20020a056a20914a00b0018c0651c40emr28205199pzc.50.1701452271350;
        Fri, 01 Dec 2023 09:37:51 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:27ef])
        by smtp.gmail.com with ESMTPSA id gx21-20020a056a001e1500b006930db1e6cfsm3255376pfb.62.2023.12.01.09.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:37:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 1 Dec 2023 07:37:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
	Sebastian Jug <sejug@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH-cgroup v5 1/2] cgroup/rstat: Optimize
 cgroup_rstat_updated_list()
Message-ID: <ZWoZ7U8f5NNwimej@slm.duckdns.org>
References: <20231130204327.494249-1-longman@redhat.com>
 <20231130204327.494249-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130204327.494249-2-longman@redhat.com>

On Thu, Nov 30, 2023 at 03:43:26PM -0500, Waiman Long wrote:
> The current design of cgroup_rstat_cpu_pop_updated() is to traverse
> the updated tree in a way to pop out the leaf nodes first before
> their parents. This can cause traversal of multiple nodes before a
> leaf node can be found and popped out. IOW, a given node in the tree
> can be visited multiple times before the whole operation is done. So
> it is not very efficient and the code can be hard to read.
> 
> With the introduction of cgroup_rstat_updated_list() to build a list
> of cgroups to be flushed first before any flushing operation is being
> done, we can optimize the way the updated tree nodes are being popped
> by pushing the parents first to the tail end of the list before their
> children. In this way, most updated tree nodes will be visited only
> once with the exception of the subtree root as we still need to go
> back to its parent and popped it out of its updated_children list.
> This also makes the code easier to read.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.8 with a small comment edit.

...
> + * Iteratively traverse down the cgroup_rstat_cpu updated tree level by
> + * level and push all the parents first before their next level children
> + * into a singly linked list built from the tail backward like "pushing"
> + * cgroups into a stack. The parent is by the caller.

I found the last sentence a bit difficult to understand and changed it to
"The root is pushed by the caller." That's what you meant, right?

Thanks.

-- 
tejun

