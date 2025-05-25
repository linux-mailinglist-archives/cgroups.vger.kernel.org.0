Return-Path: <cgroups+bounces-8344-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9220AC3263
	for <lists+cgroups@lfdr.de>; Sun, 25 May 2025 06:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD443BB26F
	for <lists+cgroups@lfdr.de>; Sun, 25 May 2025 04:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A1F42A80;
	Sun, 25 May 2025 04:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LDji7buT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD07DDC1;
	Sun, 25 May 2025 04:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748147721; cv=none; b=Tz5bwWr4KJASNRApCHpIsobRaEK6xDiYZ+AhzsrU/aWLEMK0dKFnl49ON4KmC/AOBcXqP8y3/IIhqscmt6d+UcPI7UG7BPdsk5GGUwNw/6jdXN0UO2QPlMg2NvSvJD7xJkcsVUMLMW6nhMJ0mi9zR6yl5wJ43fVanh9PzyRd96g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748147721; c=relaxed/simple;
	bh=oexNNWl4WSjvOFl161gIObkpdQS8O4fg/JwqTL+JRFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVfDi8eDaHKGIhVMuMHCa58H1k00IUzYjN9MxFCA5QGz+5hDgD0n9k4F6KkcxJ9o63Op82R16sLPMz9rh/NqHQypJDQmFSxUt2iKWhWefliM/tLViJqq1XQYhxyyfvxkvz9gn7i+tGgq0trSvTmUv2S41V3xmAQG10gbkXRWPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LDji7buT; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCUx0A9XBjf4GomCZycvDCw1LL4DADM1D+PpDoCD7tkMqK3EfW7wCqa7qReAxU5JQ05hU+Byk7lYr2+bZnRi@vger.kernel.org, AJvYcCXjH7gzWWGGPITKXKkca3QfHmyoQtYifZ7CrhX5uiA8Dhs57I5aJ8ECuVKtJRPRof7vhPn/WEYu@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748147715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IPNZVNiLqtEs2GEHAmcEc++EGmOvy9qF25+KZ/z03vM=;
	b=LDji7buTupDjfFko88wiw/SpDOyaE7W4yYZuw/g+CmXN3hPfKYaIGOZInoGqzGkU3HRbzj
	FC4k7E27En3LGKD7trnksRLfMoUUIJ6cjrqPKU9891X/7CxsLgOpupUmh0bDO/lBguUg03
	hE9f8cYGH0cV8Hs4Fm6GTU+7lE+Pqus=
X-Gm-Message-State: AOJu0YwaMDcCEQtklQgiXzja+Dw+ECI123ZFsCRWUitRcfJe1Yr6jOT0
	2vsw8XE98KATGbbxX5D2OlgHTCQswunAPc1oVlFyn1DaGudyoNxUm2Ck4pgTvgbBbi4llJqLreK
	7YzLirCXXStGkgOwx7OfPAX22gfDyoyY=
X-Google-Smtp-Source: AGHT+IG28sGrCLKIfSamx/ACFSXsq5CZW25FeVbH+h1UX0RCIHD+tU+SxyosRwgIdEq41it+H5YuWhgcEYaa5Hn7E2A=
X-Received: by 2002:a05:6102:32d2:b0:4da:e6e1:c33c with SMTP id
 ada2fe7eead31-4e4240835bdmr4193362137.3.1748147713623; Sat, 24 May 2025
 21:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <683267b1.a70a0220.253bc2.007b.GAE@google.com>
In-Reply-To: <683267b1.a70a0220.253bc2.007b.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Sat, 24 May 2025 21:35:02 -0700
X-Gmail-Original-Message-ID: <CAGj-7pWKDkdgpOtdd5D2cvGEq5R7hM8kD1vcnrioUFxOkTUDxw@mail.gmail.com>
X-Gm-Features: AX0GCFt70a-dohn4OLQpWCm28zJVtirQYFcqEHU9DglNx-ZcAPgnEltbZj2Y-_E
Message-ID: <CAGj-7pWKDkdgpOtdd5D2cvGEq5R7hM8kD1vcnrioUFxOkTUDxw@mail.gmail.com>
Subject: Re: [syzbot] [cgroups?] [mm?] BUG: unable to handle kernel paging
 request in percpu_ref_get_many (2)
To: syzbot <syzbot+3109abc43c8fcf15212b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Sat, May 24, 2025 at 5:43=E2=80=AFPM syzbot
<syzbot+3109abc43c8fcf15212b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d7fa1af5b33e Merge branch 'for-next/core' into for-kernel=
ci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux=
.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D155428e858000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D89c13de706fbf=
07a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3109abc43c8fcf1=
5212b
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e0775=
7-1~exp1~20250514183223.118), Debian LLD 20.1.6
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>

The tree of this report does not contain the latest (unmerged into
linus tree) mm patches from mm-tree. I will just wait for the
reproducer.

