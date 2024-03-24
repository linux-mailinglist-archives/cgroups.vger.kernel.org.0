Return-Path: <cgroups+bounces-2145-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B79887E2D
	for <lists+cgroups@lfdr.de>; Sun, 24 Mar 2024 18:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997421C20990
	for <lists+cgroups@lfdr.de>; Sun, 24 Mar 2024 17:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104E8199D9;
	Sun, 24 Mar 2024 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cuz/wuUi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC9D1841
	for <cgroups@vger.kernel.org>; Sun, 24 Mar 2024 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711302320; cv=none; b=XyKKOec4AYQgUnBbkIaS13LwFeHxnrQcS1N7peN8CgLSonWAj76bzpHjeyZwKZYjEu9k7Lz+yI2MWIeuD/MwRBI6lhrbaJBSgBqVDcxqsHs78P4+8vjgtyL79RBiaw7kJO8Vu3Wr4aIFM4ZUgJbgf9japbsN9/6sy+Btu8VWUu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711302320; c=relaxed/simple;
	bh=xdIW6mBPIRVyFNi0g6EGkmhDMUnRw/D1b7czg+0i/ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RI21Gu1nOLKauU/2katbhzsDpOSv3jPr+JZH55vfPfZOoBmRzUYDS8ohLW33jrT+CjM8DkvJYtoJmTc2vVg2N5r4fWaz4J7HvlgA9tl09kfxesVlS91vjiRh4S/PQFYZosCocZjtKE2dU66d4yqYlXACB7wk+K647OcQPz1w/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cuz/wuUi; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51381021af1so5588185e87.0
        for <cgroups@vger.kernel.org>; Sun, 24 Mar 2024 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711302317; x=1711907117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oe6GIQzO/C567doEXwsmBSySXlt6oy2RX728KJkYzKg=;
        b=cuz/wuUik3HMnipgbKl49knUONIng5nCb6owYldFOa8oqyekrKdz8CXhHZDcF0c36r
         yJ+3e1lI1BSlsZoioQ1RfsMcVut2iEYDDUOmggpVxkKILQQMu3+DH/N635ZR5F/6ys+h
         spbWrOaD7TFDHtX9/U3C/jO8S2YN4bEP7C1is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711302317; x=1711907117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oe6GIQzO/C567doEXwsmBSySXlt6oy2RX728KJkYzKg=;
        b=DXI/HEmkBZh6ix1QuRvOeOxa2bH0jfmJqaMJWJrnAKWTUKqcAhzAgOPUO4YpQGDFBh
         4qp8UKYM8VJxnyVSjFH0WlKVDAnqw1AAYqvbDrjVcCBdc25EtxjIavGBdb98gY6Sj2TF
         fzBrQ7zCnqP5YMeJhzLE0TChNMl0uB1OJZ6bnORLaxoXKRIYY0stlfw6VWPm+wu5x5Jk
         nV5JPBt+E6qxlzConHA+BPz3yM5rP6mcTqd8LQSfdAOh2RuYXNJnqYqlUaPqRy9K70VU
         3pqhQ9bzGGRjlAt0R64qATP2vkKGRNUC6obxdl98Po1UO7pH/8V2Y8Zvu+LJ/lT87LA0
         x7zQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6V01/N7kGlSRKgHN4jHUbacBR39wWO3eXKK/vgA8BCYs2ofnzOUSmDkrhaVaQh63ZB0ERSPLTTnoJwlsvWbgh9J3n3z3XFA==
X-Gm-Message-State: AOJu0YznlLNjxaC5FxUQKIcHpVcoZN/cz3hSiZjphcnf9jLDZv2mBXoY
	JVRahHC1qxzBJMMf06zMf6fPNxlS3eYwt3ueVW23EWWxCoT1V1NTGE5GgavUWY1bct/rNuSUiBO
	qFsim5w==
X-Google-Smtp-Source: AGHT+IHMz6gMTD40SWMHolMQ0WvWoA1Z6vvPbI9aXieA2cONUpb46cOWAl/WD01dXnZqHKHBz9CBEw==
X-Received: by 2002:a19:7702:0:b0:512:fe25:550b with SMTP id s2-20020a197702000000b00512fe25550bmr3436663lfc.47.1711302316954;
        Sun, 24 Mar 2024 10:45:16 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id zh20-20020a170906881400b00a47531764fdsm767492ejb.65.2024.03.24.10.45.16
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 10:45:16 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41482aa8237so8817675e9.2
        for <cgroups@vger.kernel.org>; Sun, 24 Mar 2024 10:45:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXazA6LjsQWl77I9Ka4czK8HCQmP/cfRUt1NOhAO5ebu3RAy5ptnO8WE/1Q1S1IC1NkZ2HY6N/YewPypdqm7eH85OrAmhMVAQ==
X-Received: by 2002:a19:ca19:0:b0:515:9ce3:daa3 with SMTP id
 a25-20020a19ca19000000b005159ce3daa3mr3631407lfg.37.1711302295763; Sun, 24
 Mar 2024 10:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-4-359328a46596@suse.cz> <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
 <20240324022731.GR538574@ZenIV>
In-Reply-To: <20240324022731.GR538574@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Mar 2024 10:44:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBQPxKh1cGhGoo=SmJq72H4VObrkVxQepooaq18H4=oA@mail.gmail.com>
Message-ID: <CAHk-=wgBQPxKh1cGhGoo=SmJq72H4VObrkVxQepooaq18H4=oA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] UNFINISHED mm, fs: use kmem_cache_charge() in path_openat()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Vlastimil Babka <vbabka@suse.cz>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[ Al, I hope your email works now ]

On Sat, 23 Mar 2024 at 19:27, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> We can have the same file occuring in many slots of many descriptor tables,
> obviously.  So it would have to be a flag (in ->f_mode?) set by it, for
> "someone's already charged for it", or you'll end up with really insane
> crap on each fork(), dup(), etc.

Nope.

That flag already exists in the slab code itself with this patch. The
kmem_cache_charge() thing itself just sets the "I'm charged" bit in
the slab header, and you're done. Any subsequent fd_install (with dup,
or fork or whatever) simply is irrelevant.

In fact, dup and fork and friends won't need to worry about this,
because they only work on files that have already been installed, so
they know the file is already accounted.

So it's only the initial open() case that needs to do the
kmem_cache_charge() as it does the fd_install.

> But there's also MAP_ANON with its setup_shmem_file(), with the resulting
> file not going into descriptor tables at all, and that's not a rare thing.

Just making alloc_file_pseudo() do a SLAB_ACOUNT should take care of
all the normal case.

For once, the core allocator is not exposed very much, so we can
literally just look at "who does alloc_file*()" and it turns out it's
all pretty well abstracted out.

So I think it's mainly the three cases of 'alloc_empty_file()' that
would be affected and need to check that they actually do the
fd_install() (or release it).

Everything else should either not account at all (if they know they
are doing temporary kernel things), or always account (eg
alloc_file_pseudo()).

               Linus

