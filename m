Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034C0A4F59
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2019 08:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfIBGsT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Sep 2019 02:48:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36315 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbfIBGsS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Sep 2019 02:48:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id g24so14647877edu.3;
        Sun, 01 Sep 2019 23:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMzxmnkxNJ25Ubbbpj3fmyVSXQrVBstVeDl3+hULd4I=;
        b=ALTtMzFn01urPW1oTRJx8B8KaMUkx5MsYciorahuYhsXjqCHHMYHNTyPmOlvxbP8H/
         7y34YPgWOWXKI6kZgpy/CbydTQFA6W6oEtPvXdi670yMBN8T59o9xYDh4yrC/jx5wmsq
         SS20Qct5zUK4wP0LTYZohQqqcZOSgg/aD2qkVkSvaPVAe5s7otwTtVWomLlmjIyLxwL7
         ia9wKVWkXkd7b0IWIB3MUucyEN2xttcLijQZsmMl9XOGA9dhKvo2oZIclli1IUkvJAMA
         GFWhSM3pluYyrWl1n2qUWnt10pZ0F+2uQIrQzM/mZpYz5HkbWfCdU2pKKNajItqKcnhK
         iUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMzxmnkxNJ25Ubbbpj3fmyVSXQrVBstVeDl3+hULd4I=;
        b=rLGjmciprRP9Z3+NlnL6U/iZXJnAGJfJ7qywqV78cCl1cJrszpL1Uw9WqAEUzxeipT
         8+m1d/Pb/d6WBLlAymY2Toy8PC8b/eCzYgZ7DWP4BBWlaJPJb+PaArAlt27KPBDM55k2
         9QGvXjXcLkcEz0tQydpanaNAFlM4LREvkbgfkDvMtooRnf7rNNphcd+wfp7AA/kSZdwh
         x2c5iKjoHRoM2xM9zWZxDH6saUdhp3VVr6a1XYXVcPkveuxoT6BmMWrHS+YrEIop2scl
         s8hH/9QARklWQyqkrw85STViyxPiu7tXhVuep17MpXRWQxTL8zPZzpudtE5V6bzt0WZ6
         4eLA==
X-Gm-Message-State: APjAAAW3imAw+H8RckK+TAoIo8iqrn2OOoesLaRoCerDXFYeUBAJ8vbm
        NB/4+YXkn+oPoB/4Eykk/2AvTaiKSMHIVLJoNvg=
X-Google-Smtp-Source: APXvYqzGihimDDSWtJAd2yaFgMbx6LJ81FUWoXBLH4T0sqyOCcAtVf84W+zYWESRiBrOKJmun8iXSLF6tyFJki+S498=
X-Received: by 2002:a17:906:4890:: with SMTP id v16mr23423271ejq.296.1567406897106;
 Sun, 01 Sep 2019 23:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190729151346.9280-1-hslester96@gmail.com> <201907292117.DA40CA7D@keescook>
 <CANhBUQ3V2A-TBVizVh+eMLSi5Gzw5sMBY7C-0a8=-z15qyQ75w@mail.gmail.com> <201908291652.46E2D65@keescook>
In-Reply-To: <201908291652.46E2D65@keescook>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Mon, 2 Sep 2019 14:48:05 +0800
Message-ID: <CANhBUQ1NvLc7vxMJsFpCN2X502d8TwZSVNTJPfg35Y_ocUpYPA@mail.gmail.com>
Subject: Re: [PATCH 01/12] rdmacg: Replace strncmp with str_has_prefix
To:     Kees Cook <keescook@chromium.org>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Laura Abbott <labbott@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 30, 2019 at 7:52 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jul 30, 2019 at 02:39:40PM +0800, Chuhong Yuan wrote:
> > I think with the help of Coccinelle script, all strncmp(str, const, len)
> > can be replaced and these problems will be eliminated. :)
>
> Hi! Just pinging this thread again. Any progress on this conversion?
>

I didn't work further on this conversion since it seems that developers
are not very interested in this problem (only half of my sent patches have
been responded till now) and I am working on other projects recently.

If the Coccinelle script is needed, I can try to implement it next week.

Regards,
Chuhong

> Thanks!
>
> --
> Kees Cook
