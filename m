Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2856988A
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2019 17:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfGOPqx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Jul 2019 11:46:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44482 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731884AbfGOPpG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Jul 2019 11:45:06 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so34741425iob.11
        for <cgroups@vger.kernel.org>; Mon, 15 Jul 2019 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScxfIM+hKDT1VQaIZy4BKqol+JPqVs71rTa7fK4KN1M=;
        b=gnHK+c2cwZGKOdspduqrUgKCh6lVrsKIInyhuuavEpiiOcbGli77C58lcIXgh934gd
         X+tLt3k+Ik4aenfsxG9NFO2TPCD832u+KzaI36GcEuU2FPeWtzF+N76i6iSHvlttqWsR
         k+frcRdRsmUd5oRFAvWQ9JfUk8UTM29DlkBao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScxfIM+hKDT1VQaIZy4BKqol+JPqVs71rTa7fK4KN1M=;
        b=AM6wIkJRiS8qJqT4IlnKgfPI0RMohc9/Q7KNJLNKmLzeXCFo8VnppKQHt/4Q8WSZFq
         UnaU9q0A6Fe6F6PtgwiFiXgfJ3+Q5TS9TQUfqPenR+VFtEjCvEZTCIJswO00Db/rEwE1
         LCnocN/GtODb52k1DZ5r2eEvggDPvMz/3LPUS/HWfRNQX2vNITq48vjOqSPK7c9iQcha
         IQa2S2xmZVbBhi8/F7H6R2le0uERJHXQBvmL2i515zRkycggRRjdjBgEXmiqGp5kJUkT
         jgMDZAKjRbuohjw22tand/pYsNAHwkVj/USv4EFU1hacLrDKaUclH3Z6BQvBTmjVLe/w
         0Alw==
X-Gm-Message-State: APjAAAUsvhsPREpFqsvQAZfwX/MbtZ4Ug6VThRt+zREDyMjgDOg/MOJ+
        ErlmtWI8meAPmZ4U+XKwyfzMc71h8UoeTpCiMffq9Q==
X-Google-Smtp-Source: APXvYqzbMN6ZWpAf5P2ZPcRYCxnKHbAAGVINWdGhBwNhv+b97qeWrnWhIxrRo/FNE6Q1bMyE5Gf6q1fus5Od5lXuuKQ=
X-Received: by 2002:a6b:790a:: with SMTP id i10mr24067436iop.150.1563205505726;
 Mon, 15 Jul 2019 08:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
 <1561664970-1555-1-git-send-email-chiluk+linux@indeed.com>
 <1561664970-1555-2-git-send-email-chiluk+linux@indeed.com>
 <xm26lfxhwlxr.fsf@bsegall-linux.svl.corp.google.com> <20190711095102.GX3402@hirez.programming.kicks-ass.net>
 <xm26v9w8jwgl.fsf@bsegall-linux.svl.corp.google.com> <CAC=E7cV4sO50NpYOZ06n_BkZTcBqf1KQp83prc+oave3ircBrw@mail.gmail.com>
 <xm26muhikiq2.fsf@bsegall-linux.svl.corp.google.com>
In-Reply-To: <xm26muhikiq2.fsf@bsegall-linux.svl.corp.google.com>
From:   Dave Chiluk <chiluk+linux@indeed.com>
Date:   Mon, 15 Jul 2019 10:44:39 -0500
Message-ID: <CAC=E7cVSVqg8raXgVC8f7wB+BJO8TAjSU=0UN-M+Oxuo2raXAw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] sched/fair: Fix low cpu usage with high throttling
 by removing expiration of cpu-local slices
To:     Ben Segall <bsegall@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Pqhil Auld <pauld@redhat.com>, Peter Oskolkov <posk@posk.io>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 12, 2019 at 5:10 PM <bsegall@google.com> wrote:
> Ugh. Maybe we /do/ just give up and say that most people don't seem to
> be using cfs_b in a way that expiration of the leftover 1ms matters.

That was my conclusion as well.  Does this mean you want to proceed
with my patch set?  Do you have any changes you want made to the
proposed documentation changes, or any other changes for that matter?
