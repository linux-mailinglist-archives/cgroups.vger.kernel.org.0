Return-Path: <cgroups+bounces-11309-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3398C17894
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 01:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7740540609B
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 00:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E376274FEB;
	Wed, 29 Oct 2025 00:25:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4C726981E
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697511; cv=none; b=MLX33qiiDN41KOskXJUKB3A7Txu6W+/jjhOIQ1UyQbHygTy3LJx9J4Tvgyo5VO6xYOETaEBss9ialaBtvEHGwpMQRyH5UCnN689f9CRwOA6o2xTDke2V+j/G+AM8OdKSTqSOCBypRJmG4OL18tP6x1+ICoQkDQdiCfLJHHBY2Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697511; c=relaxed/simple;
	bh=DjcBVY8mJqbGJnCRObWENCx0c6xRt7QNzm9li1dg71c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=owIs6n2LN4mYO2J3azAa0mlM8gB24TrX4NC0IHdUGGz4erfyRbFYhlQt65Cmmuz9OkYBSLxg8YIhFboy8cpV9QyPT1zXQsXNLpSqC9TWWJMbBx+8VZFidJPR4KmyHGhXbRXdu12RSExdX3dSqovXwpLNStWGfn19c5V7BRO+Om8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430db5635d6so87445475ab.3
        for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 17:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761697509; x=1762302309;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjcBVY8mJqbGJnCRObWENCx0c6xRt7QNzm9li1dg71c=;
        b=Hl+VLmKzNzC78iANQLN5w6QCCg7kYd6QhoWTRdk2dJ3Ep3sclt8ooM/OycK2vqz/LG
         N3T/36jnKTgRMQagqA0g0kYA2PXrsVm+lCh2CIJhlaWBclF08XymIX8xJKTRXLKn+0rY
         CFVCtxr4QxY9khHUnyN/GWAyOJrh/m7noOzrTgt42sAtIq0RrcCOcCmaCiD8e0yUg3J/
         clKMH4XUEGq8QxhkCatUAlkThnLT0L4FoP9pa1TMx6OVDFHviyEZZdsXGNsgqNoqXCr2
         8sHIrqfgWfJV2x4urhLsGarAuzux+BPHTl2agjcAqS67aUAo8SCEP7Mb3HFh+8hgWhEJ
         XAsw==
X-Forwarded-Encrypted: i=1; AJvYcCX41GATE5Mm9Jcy7lNAYWLtI8i4vg94UfCfjxd34iAR9eZy9CuBkfl/WOxIee3qBjxs/osrAobP@vger.kernel.org
X-Gm-Message-State: AOJu0YxoPWGRpc+IxIX7jBVmS4zsLxmsfN7HNNoyQSwy5pUaBVh0LNGJ
	m/FkOa5xINxqLCtXjPT7gM9iMnB5Do871XkaiBxluSK6M/vkNrlmYNMi+Hveie+A44Lk6HzRl+c
	qJOsGqmLo6/T5muY2vkJISc1YRIFNatiW5c7lMFvofeuWwnFiP45I/1EnPeQ=
X-Google-Smtp-Source: AGHT+IHRPJ5vQoHGCAChMRTb+GIwk2dkZrqG6byeJVWlhSwoPis1XmTYkNmxVcxDmVOk4U7RHrNmmt0Y0/QA/uPrHF/tucDVAqRX
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:9:b0:42e:d74:7252 with SMTP id
 e9e14a558f8ab-432f906642amr16004065ab.31.1761697508978; Tue, 28 Oct 2025
 17:25:08 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:25:08 -0700
In-Reply-To: <aQFeMG8WEvrWaNf0@hyeyoo>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69015ee4.050a0220.3344a1.03f9.GAE@google.com>
Subject: Re: Re: [syzbot ci] Re: Eliminate Dying Memory Cgroup
From: syzbot ci <syzbot@syzkaller.appspotmail.com>
To: harry.yoo@oracle.com
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, 
	cgroups@vger.kernel.org, chengming.zhou@linux.dev, david@redhat.com, 
	hannes@cmpxchg.org, harry.yoo@oracle.com, hughd@google.com, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, muchun.song@linux.dev, nphamcs@gmail.com, qi.zheng@linux.dev, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, songmuchun@bytedance.com, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com, weixugc@google.com, 
	yuanchu@google.com, zhengqi.arch@bytedance.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"


Unknown command


