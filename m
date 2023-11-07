Return-Path: <cgroups+bounces-213-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC0A7E4617
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 17:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1482812FA
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E22831A61;
	Tue,  7 Nov 2023 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+/nspwv"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46CD347B8
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 16:33:47 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A4E1BEB
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 08:33:46 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso9868129a12.2
        for <cgroups@vger.kernel.org>; Tue, 07 Nov 2023 08:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699374825; x=1699979625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=okZTi3QPt1EZedqBEr+4XsBtcVuaiJVWhcPJEtm/9tE=;
        b=D+/nspwvYVLce/yvfNUaSmj02YAI063f3aDaU1fXidUMRAIwNzdihLLC+UOIoIN9K5
         Ton314Bw2i/Ffy5LUhr8TsvgbCn8lJ1vk2jp0JaRLTALxPApro3q5/VUpDuzNETwXL+S
         QIRGp5Qkm2Ci2z/bI9a5jrHG+SisqOnPTkfYWffTEMn4ebc+uBhLvHP5Qk0w3m9kc7oX
         TSmNTYG+PvnaekzpAmvlzAoaUcU0Kxkzf6XIbHP7XaP/6/xCwK3mWHcetK2/ZiisPDQW
         Hp+cadWpyJ6mvdbvDgsxeu5KCsjL17gRmYwxEom1McAnRqTKTl0yHY9kQw5T3d2wVDzE
         667w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699374825; x=1699979625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okZTi3QPt1EZedqBEr+4XsBtcVuaiJVWhcPJEtm/9tE=;
        b=W9OgDrY+KqdZ2P5Jd3LI1fsi6I4pVy+52ndZMHf15uWG0nJZLROD7Dfnh+BhUtv2oH
         niKQ/Ael77EDlYaIbLQO9AH5ngUvbl6drh8Vxg9Z1o5+82ZNoxcCH6uLW6ZGD9FBwtJn
         9qXcX5Tzw8LSq59WRfb2Ka2NcEf35YoAXHtqp311N1lHZSikljAVnO2vUF/scEUkSWaY
         5yVB0I8Tkef7cbtlEAF0qAm5MOiqbDSxDuSKEqordbQoXBJTA/6Akwx6L8ev1gn6PPYX
         uieQhJ0KY+8FTEKBs2yoSUOgWEvBMwidAxvnRIoTH3oxbyJr7IZSCtokUo7f16gd7fSD
         X+XA==
X-Gm-Message-State: AOJu0YxyvG9IGsu1Ni98a2oF/eye+FiNlZ/YgBUSN3SZzNjsf/uZyBwz
	egxmCvri4XGzs7uXrQSyicT5OWWHiXOrbVKZa1+xTg==
X-Google-Smtp-Source: AGHT+IHsOp3c+kFTp872VF69vaY/rHVB78j2KiHzCzyx8dollhdOdf1quKvoM1sxgT/x2ZpLaTQaJnEsvUpb412nmp8=
X-Received: by 2002:a17:906:4789:b0:9e2:8206:2ea9 with SMTP id
 cw9-20020a170906478900b009e282062ea9mr1800603ejc.60.1699374824826; Tue, 07
 Nov 2023 08:33:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104031303.592879-1-longman@redhat.com> <20231104031303.592879-3-longman@redhat.com>
 <CAJD7tkZirDce=Zq9bm_b_R=yXkj1OaqCe2ObRXzV-BtDc3X9VQ@mail.gmail.com>
 <2212f172-def9-3ec7-b3d7-732c2b2c365e@redhat.com> <CAJD7tkYmSAg_T289jRczARsXu2sCW0GrR9VPyL04fQRKzCK0hg@mail.gmail.com>
 <659cc4ae-ca1e-fd97-b6e5-211738f7b7b9@redhat.com>
In-Reply-To: <659cc4ae-ca1e-fd97-b6e5-211738f7b7b9@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 Nov 2023 08:33:05 -0800
Message-ID: <CAJD7tkaMCP__5qf2+hCogdperkYNgBFHtuKCUF1_Smu949e+hQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] cgroup/rstat: Optimize cgroup_rstat_updated_list()
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joe Mario <jmario@redhat.com>, Sebastian Jug <sejug@redhat.com>
Content-Type: text/plain; charset="UTF-8"

> >>>>     *
> >>>>     * The only ordering guarantee is that, for a parent and a child pair
> >>>> - * covered by a given traversal, if a child is visited, its parent is
> >>>> - * guaranteed to be visited afterwards.
> >>>> + * covered by a given traversal, the child is before its parent in
> >>>> + * the list.
> >>>> + *
> >>>> + * Note that updated_children is self terminated while updated_next is
> >>>> + * parent cgroup terminated except the cgroup root which can be self
> >>>> + * terminated.
> >>> IIUC updated_children and updated_next is the same list.
> >>> updated_children is the head, and updated_next is how the list items
> >>> are linked. This comment makes it seem like they are two different
> >>> lists.
> >> Thanks for the comment. I will rework the comment to clarify that a bit
> >> more.
> >>> I am actually wondering if it's worth using the singly linked list
> >>> here. We are saving 8 bytes percpu, but the semantics are fairly
> >>> confusing. Wouldn't this be easier to reason about if you just use
> >>> list_head?
> >>>
> >>> updated_children would be replaced with LIST_HEAD (or similar), and
> >>> the list would be NULL terminated instead of terminated by self/parent
> >>> cgroup. IIUC the reason it's not NULL-terminated now is because we use
> >>> cgroup->updated_next to check quickly if a cgroup is on the list or
> >>> not. If we use list_heads, we can just use list_emtpy() IIUC.
> >>>
> >>> We can also simplify the semantics of unlinking @root from the updated
> >>> tree below, it would just be list_del() IIUC, which is actually more
> >>> performant as well. It seems like overall we would simplify a lot of
> >>> things. When forming the updated_list, we can just walk the tree and
> >>> splice the lists in the correct order.
> >>>
> >>> It seems to me that saving 8 bytes percpu is not worth the complexity
> >>> of the custom list semantics here. Am I missing something here?
> >> It will cost an additional 16 bytes of percpu memory if converted to
> >> list_heads. Like other lists, there will be sibling and children
> >> list_heads. There are also 2 pointers to update instead of one. Anyway,
> >> I don't have an objection to convert them to list_heads if agreed by Tejun.
> > Yes you are right. It's definitely not free, but it's also not super
> > costly. It's just that every time I look at the rstat code I need to
> > remind myself of how updated_next and updated_children work. I will
> > let Tejun decide.
>
> After further thought, changing it to list_head may not be possible with
> the current design since the actual linkage is like:
>
> update_next -> cgroup + cpu --> update_next --> ...
>
> So unless we change the design to link cgroup_rstat_cpu directly to each
> other for a given CPU, not via a cgroup intermediary, we will not be
> able to use list_head and the associated list_add() & list_del() macros.
> Direct linkage, however, requires a cgroup back pointer. So the real
> cost will be 24 bytes instead.

Yes you are right. Perhaps it's not worth it and it may not be as
simple as I thought. Please dismiss this suggestion, we'll have to
rely on comments for now to keep things clear.

