Return-Path: <cgroups+bounces-471-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61BC7F0711
	for <lists+cgroups@lfdr.de>; Sun, 19 Nov 2023 16:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C9CB208A8
	for <lists+cgroups@lfdr.de>; Sun, 19 Nov 2023 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D196134C8;
	Sun, 19 Nov 2023 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmtFKq+j"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD0DE1;
	Sun, 19 Nov 2023 07:12:07 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso240163b3a.2;
        Sun, 19 Nov 2023 07:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700406726; x=1701011526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EfKg+k4QXRL17tUiAU7LC5pyd3fy5K8isFLVnQcD7w=;
        b=dmtFKq+jZcJpnPfkSe1PXQ0ugDsFqnUZxwQx+4ekEOr1qD3gLZ9Vr9rGbiHGAtVH8X
         C090A1Cp0HAwNsSh7nAarA2TTsRYGk3F6GJvKdTr/nL06lRngWzZ4Ig+C6z0OP8gGuf2
         1VphekuV/hZFKyslv1Czd06LDRE7YfqFtG3L+HcqZu+OxI/2UuIEYBUzzgCMvYbB7aov
         d0n/Y/owHq79zShE/K18fPitRgDR+fOZ44GXuZ/6lWxnmYFqFKV9w/lgZuH/IHhyoH5p
         qo8pAUbeCdELHbWxBfqka9MQqn5sHCEAo0wCk2bAhYzofwzYcxoBYrL2RoKAeVIFoNen
         jR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700406726; x=1701011526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EfKg+k4QXRL17tUiAU7LC5pyd3fy5K8isFLVnQcD7w=;
        b=Zcmge/JaETPw74VQ0OsmlhmqM6D/eq+d82ZW//CdT0sabBd4J7pKEZ/+O/V+GP54ZH
         oLgsawne6M9JIX84bygsvpynv1DHBwJgqPrYU64H9Q/1Y5bZQODblNS7U+rdvGPbbE80
         CxeXQmYFPeGggpK43nGMJjZMrfRb2RafZZuLzqOf/xmptEqkTrhVhay7pTj4dinnRaDL
         ofIueT1QyJGr5HIBUauE3KYv1PKCxDj4P59l3PFoMOZ9RJAk5FbZYuJ41PWG0bkbo7KI
         5S04a/vuIMEueuzxRuPMcuaWX2cE+cgPrxv020MkKiguT3S4CTWVjPN2LgFbLeu5Bbny
         yd/Q==
X-Gm-Message-State: AOJu0Yxe/jacuppVha4cjGQ/GneI6xSC6elEsizYzvL+NsyuuEeGXsHK
	SO1dw5HaK+QbTl/1Dt7kaP4=
X-Google-Smtp-Source: AGHT+IGh5ysb2zBhFrgP4U+InFADY6GOsfaeTyqut6gkNtKaowLrmsgaAc4wNSKRcUjW5I0K14W/NA==
X-Received: by 2002:a05:6a20:6a0b:b0:187:b2a7:c6cd with SMTP id p11-20020a056a206a0b00b00187b2a7c6cdmr3685940pzk.57.1700406726359;
        Sun, 19 Nov 2023 07:12:06 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id x19-20020a62fb13000000b006870ed427b2sm4532387pfm.94.2023.11.19.07.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 07:12:05 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 19 Nov 2023 05:12:04 -1000
From: Tejun Heo <tj@kernel.org>
To: syzbot <syzbot+cef555184e66963dabc2@syzkaller.appspotmail.com>
Cc: boqun.feng@gmail.com, brauner@kernel.org, cgroups@vger.kernel.org,
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
	lizefan.x@bytedance.com, longman@redhat.com,
	michael.christie@oracle.com, mingo@redhat.com, mst@redhat.com,
	oleg@redhat.com, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com, wander@redhat.com, will@kernel.org
Subject: Re: [syzbot] [cgroups?] possible deadlock in cgroup_free
Message-ID: <ZVolxA8RHsY11CnE@slm.duckdns.org>
References: <000000000000f5b0d0060a430995@google.com>
 <0000000000009642b4060a4f017f@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009642b4060a4f017f@google.com>

On Thu, Nov 16, 2023 at 05:25:05PM -0800, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 2d25a889601d2fbc87ec79b30ea315820f874b78
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Sun Sep 17 11:24:21 2023 +0000
> 
>     ptrace: Convert ptrace_attach() to use lock guards

Looks like the tasklist_lock conversion in ptrace_attach() forgot _irq.
Peter, Oleg?

Thanks.

-- 
tejun

