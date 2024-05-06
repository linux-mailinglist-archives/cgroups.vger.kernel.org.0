Return-Path: <cgroups+bounces-2794-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87748BD234
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 18:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7899C1F236BA
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 16:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0036D156256;
	Mon,  6 May 2024 16:13:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE8142E63
	for <cgroups@vger.kernel.org>; Mon,  6 May 2024 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011991; cv=none; b=ASGFIMsZz8HP1TRqeoOvlgSObbWC744b0KvhxtkU7L5lCIO8o5OnIi+PWOPHuCFdzCQ1ytjy0EKVPeTaiMnXq992OYM5BKasqjK20RrKuhZdN3RMCssySfh8wdmanFnUO4HbeqlOvCo48/nt0LKJajoE1nEWEHBHicjn/AI25eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011991; c=relaxed/simple;
	bh=ZDuc0bd7d2esyW0N0xgu6X4mLxxg42OU+AYdnX8ztC8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lpvjoy6sBKhkaLCseTA1/A2FemZ+1ywQAUMRiV3anoTBf7+iGKMlqZrXyL/FQ5AdkoUQ/kHsIzJ5+uEPc9UB7RJ1z4x60R2J7S9TJy3FMoqHpMcnyRKfTIbZYn+nf6pKS+6qK/t7u5s1mSTcA0EDHkr8FYcgNMCKY5FHaBfuWeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7da42f683f7so145157739f.0
        for <cgroups@vger.kernel.org>; Mon, 06 May 2024 09:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715011989; x=1715616789;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzW/d3ZqkQk8J/YaIz3cVJ91ezIDBpLnkIAi9wdOK30=;
        b=mwQpIWM1GZhiJ4b5Eiy+IVdfaQD8DcO+B6fp+HFUbiB7ojCtQlJUhf+xj/Xy03RQZM
         /huK3aFynVFVMmL40wvmULb6DcVOCr08lQQaSPWhw2in+mJk6VjrA1USXcVaz03Fimb9
         /8keK+PUtqHw+nekzUn5yyKWTojSd+oR0GmfF7zvbHsoDKf7Nlpn/LKwswFsJHAXQEMe
         9E8vdPBiplTBULPS6ntvHOPGDflZGwG3+1Ppa6s6eOomMLvUWrB6ZrgexPqwFMCa5tUK
         o/eafRLqoTB7gEVWtUbIWEax+nYTSZBdBr25yRQjeIa32HUcqAiEF/GvQeYIYnY2hMdA
         Hqrw==
X-Forwarded-Encrypted: i=1; AJvYcCVmmFowJDSURElmYUJDUYlu2Z4tnVD6j9/H+PK8Wct41xbJgNkxzR8YwutP1d7VFGv724CK9xgny1vqyFrj07FCwcXEAZ5ehg==
X-Gm-Message-State: AOJu0Yx+wAjfGPak1KxR9i6Iz7UVwo1RvLqm04m2ig2sIRSLbefhHJYj
	gL6xVIUUWBdFsi+pE2IRjwStMQXsgfH7eq8ieG7sOTcxUyTAxChshF80QIokaWLPBo1luWOGC5V
	raw1sZaLP8GDWvwn5dt2IEfxcLbJmpUnXZGtnBJrmX6vPx/oYlfYBi/k=
X-Google-Smtp-Source: AGHT+IFELdI7ElEUrZpuXFZ2wrxRdaC0IB3Akz9+WKZboJ88RJE3880HwZQgtxZ6ObuUo1fDxcN3K0jY0nG5kQxLtpPr9ZGk8Uh3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8309:b0:488:cb5c:7044 with SMTP id
 io9-20020a056638830900b00488cb5c7044mr7957jab.6.1715011983899; Mon, 06 May
 2024 09:13:03 -0700 (PDT)
Date: Mon, 06 May 2024 09:13:03 -0700
In-Reply-To: <ZjjlLcjHuQoV-7gh@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001623740617cb58a7@google.com>
Subject: Re: [syzbot] [mm?] [cgroups?] WARNING in __mod_memcg_lruvec_state
From: syzbot <syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

mm/rmap.c:1444:25: error: incompatible pointer types passing 'struct folio *' to parameter of type 'struct pglist_data *' [-Werror,-Wincompatible-pointer-types]


Tested on:

commit:         2b84edef Add linux-next specific files for 20240506
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=b499929e4aaba1af
dashboard link: https://syzkaller.appspot.com/bug?extid=9319a4268a640e26b72b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1655a590980000


