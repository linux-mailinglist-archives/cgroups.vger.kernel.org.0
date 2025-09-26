Return-Path: <cgroups+bounces-10470-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7BABA4729
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 17:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7429A7B036A
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 15:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277619FA93;
	Fri, 26 Sep 2025 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZXa98Bu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2941EBA1E
	for <cgroups@vger.kernel.org>; Fri, 26 Sep 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901134; cv=none; b=nFzfL/+A9oYnzjmDAvvCsYoPombwMfyU9pnb7u6urtL2VyJXDLB4HNGdLwyluyJezzov35Srb2GgpQ3WhcNZoT48K7V7o6H2j/LHzvWmhJu9OWeyR94tIBaQd6tqdDIpETPNAAvA6OOd2pDzPKinw7dqp7D7WhwJwsP+s9wRkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901134; c=relaxed/simple;
	bh=BTM94BFpp9aT5IBTYgdibKSNLxc/Kf3Lda1oqYpQooU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oytSSY438xhA+umjafkrWbGOFS8kFcvSULtyz/xnojPPnv2JNhaVxlYx9oWdY2wx+OMQZx+FsOFYNKT0WywuiZ5bIuim6Zku2LilQoCWQs643/DLkCCiTh1bOPD4D1vsR5dzOiLJScT/5Rg4hFwCL7sLvGyhEKnigZUdg83GGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZXa98Bu; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4de60f19a57so255041cf.0
        for <cgroups@vger.kernel.org>; Fri, 26 Sep 2025 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758901132; x=1759505932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXzocX6ZDXcHxojnIagSNZA3qKAOhB8e13p864rbCw0=;
        b=TZXa98Bus+huhfRJ0vgyDERvWcI2YlLQG1InPC+eyaRpAyELLTYTxuK71QEFCBaVMB
         EX1YQAIvvevXRrth4DBYL5wwdleIssOVwN4vyUGgFtIiLqwRzOafY8J6VqqZN+JWXmF7
         L1dcnmxCA3g1bGGDIojzlKMp+06KKdPZunud5ON1Z9nWcQYKYn2t43GHtKHCkK7MLdYO
         7+od/zK6iw/5bkcLjc5KsmbQ5/tHrQ1A825mtawiYXAbWL8axjCS8jcPHWPbRutedkH3
         WnWGeWVjJ0NVOkVLqILOTbU4fygVFFrDkvoGVe9qTK7tirVXIrkWTp+yRiKkSzFvz8iu
         MqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758901132; x=1759505932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXzocX6ZDXcHxojnIagSNZA3qKAOhB8e13p864rbCw0=;
        b=AojMrb1Qe+eJ2iXxqDoh3Q3yFHQN+cjzsgHg+KYHPTYHi70zHvgeyRqDRDA1Zhixps
         l0ObiySx7HyQCKrGJMhShT8NUHW+KhUPwqV0wq2fwjbeivJMbb65aMNdReDzn7uw/ZD+
         ifOPnCERnj/rUEcAR++l6wAiEh3ged3cQw92kOWKxG0fzLSE50BPEsT5Md+3uyyCxch6
         U3vzpowW/x6dg2H/vjCZjQ1KKV0FUB5MFo+CxDmOesnU0pD6aWdBipsSDQAKUm0IGrWI
         weEiOtAPNRdWkbS1KrdnPjWm1CoMAX3lmUTl9HmsiUTJNLuEeQcZqhzeDOfyCapKDWTB
         91Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXff8Hx5nQcud3GzXTDcQxKV641LfqfPhwaqzb1Yy/oZpHbUDBzyFjy1Hrk7q/mJO6EwYR4Su7C@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5+3rU5+e3eszQpUPAjBH6z1CTS8PkB2vGuE8DF93DOtUSvO9o
	Y5Ul2ZqYqWDF/vC9e1mFDgCehZnQLe00H9SpdBowaD7YG+7Xa7DMsDUJaGeBcOGfjMiMVmdpU2A
	S5qg69WVmJQ943NsFAevP9vVItkdEtnJ8WtGfySfh
X-Gm-Gg: ASbGnct3/rX7fRyBmTob2Jma4gfWFwwpHFcE7VZo/vpjuBSpAXnXeWifLIWX1grT2Rf
	dVs6EVFg9f7ltgC3AymvIGNlGA5lpWTHqHn0TrMI9yC+I+lhDfZYx0XsdcmrjrxLvS5pLGvUYPd
	oJ2f7wv0DNfZ6g415lt7UjO93zsI65rcM/pd2o6P+DIo1TgRuh0oi0RFiZ+5omgLZYZWPXgSzNM
	SeuPRdItmJJ
X-Google-Smtp-Source: AGHT+IGUxL+Ts8nZMxqg7rMa5w9X1kAO9wkdvMmX92FoJO/bv4bqeUj1oEI2kGl0p735VGIj1Vtf4Ntxfyo6WGTFanA=
X-Received: by 2002:a05:622a:14c:b0:4b7:9b06:ca9f with SMTP id
 d75a77b69052e-4dd1675a20amr6251731cf.2.1758901130945; Fri, 26 Sep 2025
 08:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202509171214.912d5ac-lkp@intel.com> <b7d4cf85-5c81-41e0-9b22-baa9a7e5a0c4@suse.cz>
 <ead41e07-c476-4769-aeb6-5a9950737b98@suse.cz> <CAADnVQJYn9=GBZifobKzME-bJgrvbn=OtQJLbU+9xoyO69L8OA@mail.gmail.com>
 <ce3be467-4ff3-4165-a024-d6a3ed33ad0e@suse.cz> <CAJuCfpGLhJtO02V-Y+qmvzOqO2tH5+u7EzrCOA1K-57vPXhb+g@mail.gmail.com>
 <CAADnVQLPq=puz04wNCnUeSUeF2s1SwTUoQvzMWsHCVhjFcyBeg@mail.gmail.com>
 <CAJuCfpGA_YKuzHu0TM718LFHr92PyyKdD27yJVbtvfF=ZzNOfQ@mail.gmail.com>
 <CAADnVQKt5YVKiVHmoB7fZsuMuD=1+bMYvCNcO0+P3+5rq9JXVw@mail.gmail.com>
 <7a3406c6-93da-42ee-a215-96ac0213fd4a@suse.cz> <CAADnVQKrLbOxav0+H5LsESa_d_c8yBGfPdRDJzkz6yjeQf9WdA@mail.gmail.com>
In-Reply-To: <CAADnVQKrLbOxav0+H5LsESa_d_c8yBGfPdRDJzkz6yjeQf9WdA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Sep 2025 08:38:39 -0700
X-Gm-Features: AS18NWDgSteTnQAeHe58pnPN5CXO_C6LUnKFpTmB_8Hvkh2DQsaUFE0c0GhVrg0
Message-ID: <CAJuCfpG7Gf3_P6gKrUa+3iNZgq7SNd7nZa7Uq1P+v3FVHnL4QA@mail.gmail.com>
Subject: Re: [linux-next:master] [slab] db93cdd664: BUG:kernel_NULL_pointer_dereference,address
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, kernel test robot <oliver.sang@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Harry Yoo <harry.yoo@oracle.com>, oe-lkp@lists.linux.dev, 
	kbuild test robot <lkp@intel.com>, kasan-dev <kasan-dev@googlegroups.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 8:30=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 26, 2025 at 1:25=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > On 9/19/25 20:31, Alexei Starovoitov wrote:
> > > On Fri, Sep 19, 2025 at 8:01=E2=80=AFAM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > >>
> > >> >
> > >> > I would not. I think adding 'boot or not' logic to these two
> > >> > will muddy the waters and will make the whole slab/page_alloc/memc=
g
> > >> > logic and dependencies between them much harder to follow.
> > >> > I'd either add a comment to alloc_slab_obj_exts() explaining
> > >> > what may happen or add 'boot or not' check only there.
> > >> > imo this is a niche, rare and special.
> > >>
> > >> Ok, comment it is then.
> > >> Will you be sending a new version or Vlastimil will be including tha=
t
> > >> in his fixup?
> > >
> > > Whichever way. I can, but so far Vlastimil phrasing of comments
> > > were much better than mine :) So I think he can fold what he prefers.
> >
> > I'm adding this. Hopefully we'll be able to make sheaves the only percp=
u
> > caching layer in SLUB in the (near) future, and then requirement for
> > cmpxchg16b for allocations will be gone.
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 9f1054f0b9ca..f9f7f3942074 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2089,6 +2089,13 @@ int alloc_slab_obj_exts(struct slab *slab, struc=
t kmem_cache *s,
> >         gfp &=3D ~OBJCGS_CLEAR_MASK;
> >         /* Prevent recursive extension vector allocation */
> >         gfp |=3D __GFP_NO_OBJ_EXT;
> > +
> > +       /*
> > +        * Note that allow_spin may be false during early boot and its
> > +        * restricted GFP_BOOT_MASK. Due to kmalloc_nolock() only suppo=
rting
> > +        * architectures with cmpxchg16b, early obj_exts will be missin=
g for
> > +        * very early allocations on those.
> > +        */
>
> lgtm. Maybe add a sentence about future sheaves plan, so it's clear
> that there is a path forward and above won't stay forever.

LGTM as well. Thanks!

