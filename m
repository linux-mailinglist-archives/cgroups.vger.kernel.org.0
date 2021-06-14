Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4D53A6E15
	for <lists+cgroups@lfdr.de>; Mon, 14 Jun 2021 20:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbhFNSRH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Jun 2021 14:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24908 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235045AbhFNSRH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Jun 2021 14:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623694503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XoLLCXJLmHm9xP9JVi6L/4crsU3Bp6fWjhRZ5/p958Y=;
        b=NvqhF2j4hVetN7H5/8FCaawGOlj264250DN3QfNc+OvVrbxElRLNEHRlrJfNqMSQFavTf6
        MTHX4AuTr3gi4M1faiiiOF2wywk0YutUie6zccuQgf8kRtT8tg7ambG3zP8GILBmjViWjK
        mwRS7PcT95/Kxh4JEaZU8F1XB+tTS80=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-z3QcK7ybOkqZwgQrXxv6XA-1; Mon, 14 Jun 2021 14:15:01 -0400
X-MC-Unique: z3QcK7ybOkqZwgQrXxv6XA-1
Received: by mail-lj1-f199.google.com with SMTP id j2-20020a2e6e020000b02900f2f75a122aso5061421ljc.19
        for <cgroups@vger.kernel.org>; Mon, 14 Jun 2021 11:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoLLCXJLmHm9xP9JVi6L/4crsU3Bp6fWjhRZ5/p958Y=;
        b=BeISGY9Ohm8pep+62cJ2nFvr22+9q7Dse4KzLifLrC8hxerftUjletAXm3IFe+XI/F
         7N9T0IS6bmjTZZzaEcSVZlG+kXJiWab2jNSt2Jr3w3NdpmkRjNLmta/VSt/6b6M1veLO
         DzlbUZmqnWXCudd2LHlqTOQYeZc0JtEsXauHX8kPxndMAaQtDQaoLSPHD40QJLigwlf+
         W5BfhlrCdRB6qZQ94Lg5Rck96jhFCYApgbvDj3XynPN54+ITXr5fKUsMdn0O0rI9PC2j
         BFa7/xle1EMKSfcEQaf2QNZ9E7bJ7EGwxN5r69h9IgwpSCghniidEWxXtP3MGNLWMXUj
         jI4w==
X-Gm-Message-State: AOAM533utCi8KyWgGhlntZ4jC2IPzPPrA2Z6xpqo6CeflqW92WCo8sfl
        0HmPbmZYg84Pvvj22GFaZiXbGrR/MjJ2u+cf7Ggn7vcvq/VmohESgzQZBK0hkxxKOn8GnxZifTj
        HPXl4sbQQe7bH6YZU9v62H1yQgLURAvKVhQ==
X-Received: by 2002:a05:651c:383:: with SMTP id e3mr14751185ljp.220.1623694499478;
        Mon, 14 Jun 2021 11:14:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzZpUwO131yESALYO7EwB89ztq7Jn+0azFobN4Jb1kH1ikJSy93T4qoJVCiH217Mn8G6kgyD4lpDRQotg36Oc=
X-Received: by 2002:a05:651c:383:: with SMTP id e3mr14751171ljp.220.1623694499323;
 Mon, 14 Jun 2021 11:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210317003616.2817418-1-aklimov@redhat.com> <87tuowcnv3.ffs@nanos.tec.linutronix.de>
 <CALW4P+L9_tYgfOPv0riWWnv54HPhKPDJ4EK4yYaWsz0MdDGqfw@mail.gmail.com> <CAFBcO+8NBZxNdXtVuTXt9_m9gWTq7kxrcDcdFntvVjR_0rM13A@mail.gmail.com>
In-Reply-To: <CAFBcO+8NBZxNdXtVuTXt9_m9gWTq7kxrcDcdFntvVjR_0rM13A@mail.gmail.com>
From:   Alexey Klimov <aklimov@redhat.com>
Date:   Mon, 14 Jun 2021 19:14:48 +0100
Message-ID: <CAFBcO+9wLjDW6n-ZSean_UQHSJ44Tpw9XBz-3UMoVCeUridj4Q@mail.gmail.com>
Subject: Re: [PATCH v3] cpu/hotplug: wait for cpuset_hotplug_work to finish on
 cpu onlining
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Joshua Baker <jobaker@redhat.com>, audralmitchel@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, tj@kernel.org,
        Qais Yousef <qais.yousef@arm.com>, hannes@cmpxchg.org,
        Alexey Klimov <klimov.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thomas,
Just gentle ping.

On Thu, Apr 15, 2021 at 2:30 AM Alexey Klimov <aklimov@redhat.com> wrote:
>
> On Sun, Apr 4, 2021 at 3:32 AM Alexey Klimov <klimov.linux@gmail.com> wrote:
> >
> > On Sat, Mar 27, 2021 at 9:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:

[...]

> Are you going to submit the patch? Or I can do it on your behalf if you like.

Are you going to send out this to lkml as a separate patch or do you
want me to do this on your behalf?

Best regards,
Alexey

