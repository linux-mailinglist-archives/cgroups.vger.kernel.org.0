Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF60229CE8
	for <lists+cgroups@lfdr.de>; Wed, 22 Jul 2020 18:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgGVQRL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Jul 2020 12:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbgGVQRK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Jul 2020 12:17:10 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FABBC0619E1
        for <cgroups@vger.kernel.org>; Wed, 22 Jul 2020 09:17:10 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id o3so1755436ilo.12
        for <cgroups@vger.kernel.org>; Wed, 22 Jul 2020 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcL+fVRHFbwjcT2YoeEyW0ovDsmOpco9f4REaf4pOLw=;
        b=Yubxcjwtpc7YJGf0Tziz+sT7J49N0W4XOpcuP6qz+/oiMJmZWQU/Kd8bRbKoKhkvRZ
         RnULiCwqMICOqU1HdOr0DGkfNUWsljA27n+XJ+U5D4l98CuiRYbkSXMPr4+W0DyFNtb+
         AY+GHqK5P2TwUgTqNVgFJTxJoi0sTaFqqe+6N0p/LenOodA1YiaVIgE+e2BMkKkM402X
         R4n2L8/Xi3rrf4jYh3bII4QM3zJZ2tIZWJ5l8SbQpLT5zkqRCfn06WbbJYUNLuUFZK79
         2WjQU9hbziDqo4arXlFdwyZ0UC8MY80G8CFPHzWB/TsG+e4NxODiBVUvc4xDIlT2n9fa
         B76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcL+fVRHFbwjcT2YoeEyW0ovDsmOpco9f4REaf4pOLw=;
        b=VnJQNXQlvqUwtnan0NFtAKq7INIHR/1Xv68PfGP2spM5fxECN4eXfqDU9hsKZ/CfYo
         IOV7u0mDGW7C9Uti71t1pN2BR8Q9FfIMbMb6uZHoFJz0OPu62Eej7T0lRMW2toUKJyzy
         nT3wb5qXhqMiourLp0wD/zJu+vtj289462qZT6j1b3EFEnuzVjWiBuGdUb2xArgmDCR1
         ol+CCxDjMMkSGH3/7S/Q6vMgDDJ2zI3YkI/m9oXJJU/6eS0e3DwdK6NsSaCX2N9NciYC
         JTUXlxccb5CeXpKQfeKiA4Onhljtz7qo79ZxCsp0PMjOrxWEFm0GgS50v/2CPGPA4TY6
         tJGA==
X-Gm-Message-State: AOAM531RRwqYqqhvpe905df9rbpygW9h46cvT6ez6Y32rNdSFQF5KFRh
        3kRXf8BfUNYb6UwJrHBV2+44K6KHxWRLqzMgnuSNfQ==
X-Google-Smtp-Source: ABdhPJzRjVSHUdq95L4uwyL/QiKe4BnlIZ7BNNuAXtthqySJmpzNdrp3+RktG+FL20eMYaBBJOPnsGSirp9tKRuuYbA=
X-Received: by 2002:a92:404e:: with SMTP id n75mr615859ila.203.1595434629062;
 Wed, 22 Jul 2020 09:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuj3bHUMz8XQztbmTgF0c5+rZ5-FkUjFyvEftej2jLT+Q@mail.gmail.com>
 <CAK8P3a3br1bDc8C6UjRWzdmwzVV26YYe3ixHV7LH5Z0-OiqPQQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3br1bDc8C6UjRWzdmwzVV26YYe3ixHV7LH5Z0-OiqPQQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Jul 2020 09:16:57 -0700
Message-ID: <CALvZod5cBTsytQz5=EbqT_s1_ZJ8YpkBe+CLEAU+25FP4kHSAg@mail.gmail.com>
Subject: Re: BUG at mm/vmalloc.c:3089! - invalid opcode: 0000 [#1] SMP KASAN PTI
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        LTP List <ltp@lists.linux.it>,
        Cgroups <cgroups@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Roman Gushchin <guro@fb.com>,
        Dennis Zhou <dennis@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 22, 2020 at 1:55 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Adding Roman Gushchin to Cc, he touched that code recently.
>
> Naresh, if nobody has any immediate ideas, you could double-check by
> reverting these commits:
>
> e0b8d00b7561 mm: memcg/percpu: per-memcg percpu memory statistics
> 99411af13595 mm/percpu: fix 'defined but not used' warning
> 9398ce6306b6 mm-memcg-percpu-account-percpu-memory-to-memory-cgroups-fix-fix
> 54116d471779 mm-memcg-percpu-account-percpu-memory-to-memory-cgroups-fix
> ec518e090843 mm: memcg/percpu: account percpu memory to memory cgroups
> 9bc897d18dc3 percpu: return number of released bytes from pcpu_free_area()
>
>        Arnd
>

I think syzbot has bisected this issue to the suspect patch.

https://lore.kernel.org/lkml/00000000000043f09405ab01b0b8@google.com/
