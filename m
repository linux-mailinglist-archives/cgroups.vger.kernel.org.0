Return-Path: <cgroups+bounces-8043-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 605FCAAD047
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 23:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3DF1C407CA
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 21:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0DD21D590;
	Tue,  6 May 2025 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOKQvDIY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F020D4E4
	for <cgroups@vger.kernel.org>; Tue,  6 May 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567872; cv=none; b=QcpTna/A3ng3wD4Teg36KwYlMlnBXxp8t0Hxj1yqzHZFvVvQzoLl1kHlEB5dg0lPNNy8qq6H7+4Sc7xd+MJGSXXBcbS4J7nYJi2XmLtitFvz4z0w1ZfxvuJ6Adv06DVp6Cxy9wM5ihZnhYtz2zjyhgZzzBMeClJMy1P0eEiFxrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567872; c=relaxed/simple;
	bh=7+L+FPhqQuP1idG0wBsmys7t39sKDLTfx3cvUKCmwL4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CYD3UsX7yt6tx5cG0FrwF3AcjEP+MRi9Kde3dt6ghD9coFDYBFeI3YBWOH/q+jVKOp01hELCD4iUFc2mCgZs3IXigD6X9MUl9j2ZqAaHVIz6fdjTPK5GztmkWffGeQf+zAO7BX5uU0zbHr/55rD4qUE8Y0c73vL++rKBimYPAZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOKQvDIY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736c062b1f5so6432717b3a.0
        for <cgroups@vger.kernel.org>; Tue, 06 May 2025 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746567870; x=1747172670; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTOg8ZZYR+z/ies4Nu7D9sk00RCPkm3jPkcu/QULkfI=;
        b=MOKQvDIYP9W8d8esAc/8yLmKceptBXAsr2k0rN1t3n87AxfFvwDZazKp5z1UeyOpuJ
         OCpszAU8S1wxvpbZ3u9fT3eHGutJ2YP/ahNzE1tcWqD42MSRF2oolmaMKZamm8FlnBr7
         +/2GiwoUJMzrsy9R49eYebzgEZirjpMY7fBTiYdK0fsSiLS8FHneQpSXfoN8fSav71rY
         K82M3Htvd3TutERWkms5E7+/2zL3CYx+zmB/253usoNLWQFS3HW0XlEyNZJD0jhLMuZL
         xZnzBO0r8+5BCJeTa6xO0oEPjzpx1QBDUW2UTi11TO6BLDgB+LRSGtGhJ1EvGWgmiwak
         uQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746567870; x=1747172670;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTOg8ZZYR+z/ies4Nu7D9sk00RCPkm3jPkcu/QULkfI=;
        b=QTLND0S4CgVngP39Cr9bf2UXCrscJYCrx+KKwG7ztvD3s/LmzOPiTG9BVDh9h+yZ9n
         YTqo3Lu3aHPorTQvy3cJaURTJUZSmtWFGqXw1BN8AIQ87exSYkcAYkAMqYoj7UIOBSvu
         510mVEirX1o80mzxOE/R7y7roCpbRRZ/2kcr+Q1PuRy4IirHWD/P+pE3AiVjfhQlV6sK
         qeRXFqXtK2keOJUJWy2V/OyX2I4nH0LEprC5MvaVi6AG7b0j0bCAsr9fDkYKptj/J/BG
         DCKl+id+pwP9xljx8NAUZc4pGp6HWYyEkr70bQ5JgaAyhEKRFg664ARv2NY6y1U0mjrJ
         7ctw==
X-Forwarded-Encrypted: i=1; AJvYcCWvipb5Z+KQwvC/Fe6WVF7lguJG9vwOc/LBoXFdmuIy+2FkEFoT+JCj6PfvRkEoLKFrNbHXO+mA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9C3WN5bn0+GbneMCaBXmjgjN+YfRBAFzNHWHxBnQcYnKyjyNn
	9RZl9fRuvUytOYNxu28Y8Lw273CRb4LZwne5i4L/vOVEhDdwy1dnY6EmMEcV2w==
X-Gm-Gg: ASbGncsk8rEsgMqURnzEXHgUtetpSHHKDBESycfsvqwyzcV/VOJ/7eXnk0eMHpJEY7y
	y2pQLNnLeJNIr5/Jn1Jl1XfFks4HNY/4nOUOGmF5pRAWWqI6OFX+/4UPag2FCizSErw4ITA/q8U
	k/wb0+N/qBjc8IbmsHO9lpa0EMbh7/08cSqClfQyL56QY1gY4atEmmuHiGko+rHwe2C7htenTqz
	9QTPiyyUf2aSevMIIGeX+KpUD5HVRQvOM42JWzbs2/GD3f5DVx8MAOuX0n5BpN29CXOd1i1oAuv
	hBuhwkZtzG1v+ofOC7xSTNPlwMarIRoxELhbjblt9C3yaQ236+S30gUr5nvqNcvLyi1Ci/yYmBS
	Qy9Rh2YnEQUhgC9/DI2d7HU0s
X-Google-Smtp-Source: AGHT+IEXV+gmD2T9yZ9R6KnZkKIBOA06T83p7bG1KcJi94KBGZ/Zy1rFnlaiIlKAL2hyzBil4lmXqg==
X-Received: by 2002:a17:90b:1d88:b0:30a:4906:c20c with SMTP id 98e67ed59e1d1-30aac296e97mr1388750a91.35.1746567869993;
        Tue, 06 May 2025 14:44:29 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30aaeae485csm338621a91.44.2025.05.06.14.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 14:44:28 -0700 (PDT)
Date: Tue, 6 May 2025 14:44:17 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Muchun Song <songmuchun@bytedance.com>
cc: Johannes Weiner <hannes@cmpxchg.org>, mhocko@kernel.org, 
    roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
    akpm@linux-foundation.org, david@fromorbit.com, zhengqi.arch@bytedance.com, 
    yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev, 
    linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
    hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
    Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH RFC 07/28] mm: thp: use folio_batch to handle THP splitting
 in deferred_split_scan()
In-Reply-To: <235f2616-99dd-abfa-f6d1-c178d8ffb363@google.com>
Message-ID: <7fd0262d-ff36-d621-191e-4f623a2038c0@google.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com> <20250415024532.26632-8-songmuchun@bytedance.com> <20250430143714.GA2020@cmpxchg.org> <235f2616-99dd-abfa-f6d1-c178d8ffb363@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 5 May 2025, Hugh Dickins wrote:
...
> 
> However... I was intending to run it for 12 hours on the workstation,
> but after 11 hours and 35 minutes, that crashed with list_del corruption,
> kernel BUG at lib/list_debug.c:65! from deferred_split_scan()'s
> list_del_init().
> 
> I've not yet put together the explanation: I am deeply suspicious of
> the change to when list_empty() becomes true (the block Hannes shows
> above is not the only such: (__)folio_unqueue_deferred_split() and
> migrate_pages_batch() consult it too), but each time I think I have
> the explanation, it's ruled out by folio_try_get()'s reference.
> 
> And aside from the crash (I don't suppose 6.15-rc5 is responsible,
> or that patches 08-28/28 would fix it), I'm not so sure that this
> patch is really an improvement (folio reference held for longer, and
> list lock taken more often when split fails: maybe not important, but
> I'm also not so keen on adding in fbatch myself).  I didn't spend very
> long looking through the patches, but maybe this 07/28 is not essential?

The BUG would be explained by deferred_split_folio(): that is still using
list_empty(&folio->_deferred_list) to decide whether the folio needs to be
added to the _deferred_list (else is already there).  With the 07/28 mods,
it's liable to add THP to the _deferred_list while deferred_split_scan()
holds that THP in its local fbatch.  I haven't tried to go through all the
ways in which that may go horribly wrong (or be harmless), but one of them
is deferred_split_scan() after failed split doing a second list_add_tail()
on that THP: no!  I won't think about fixes, I'll  move on to other tasks.

Or does that get changed in 08-28/28? I've not looked.

Hugh

