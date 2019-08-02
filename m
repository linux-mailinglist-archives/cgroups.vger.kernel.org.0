Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC627F6B0
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2019 14:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392593AbfHBMQG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Fri, 2 Aug 2019 08:16:06 -0400
Received: from ozlabs.org ([203.11.71.1]:36859 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732155AbfHBMQG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 2 Aug 2019 08:16:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 460R2p1xsMz9sBF;
        Fri,  2 Aug 2019 22:16:02 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Chuhong Yuan <hslester96@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Laura Abbott <labbott@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 01/12] rdmacg: Replace strncmp with str_has_prefix
In-Reply-To: <CANhBUQ3pYGwKng-wxsGn3tBj3z_kN-CZQL__5YTwwJuco=fH0w@mail.gmail.com>
References: <20190729151346.9280-1-hslester96@gmail.com> <201907292117.DA40CA7D@keescook> <CANhBUQ3V2A-TBVizVh+eMLSi5Gzw5sMBY7C-0a8=-z15qyQ75w@mail.gmail.com> <CANhBUQ3pYGwKng-wxsGn3tBj3z_kN-CZQL__5YTwwJuco=fH0w@mail.gmail.com>
Date:   Fri, 02 Aug 2019 22:16:00 +1000
Message-ID: <87y30bkbjz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Chuhong Yuan <hslester96@gmail.com> writes:
> Chuhong Yuan <hslester96@gmail.com> 于2019年7月30日周二 下午2:39写道：
>> Kees Cook <keescook@chromium.org> 于2019年7月30日周二 下午12:26写道：
>> > On Mon, Jul 29, 2019 at 11:13:46PM +0800, Chuhong Yuan wrote:
>> > > strncmp(str, const, len) is error-prone.
>> > > We had better use newly introduced
>> > > str_has_prefix() instead of it.
>> >
>> > Wait, stop. :) After Laura called my attention to your conversion series,
>> > mpe pointed out that str_has_prefix() is almost redundant to strstarts()
>> > (from 2009), and the latter has many more users. Let's fix strstarts()
>> > match str_has_prefix()'s return behavior (all the existing callers are
>> > doing boolean tests, so the change in return value won't matter), and
>> > then we can continue with this replacement. (And add some documentation
>> > to Documenation/process/deprecated.rst along with a checkpatch.pl test
>> > maybe too?)
>> >
>>
>> Thanks for your advice!
>> Does that mean replacing strstarts()'s implementation with
>> str_has_prefix()'s and then use strstarts() to substitute
>> strncmp?
>>
>> I am not very clear about how to add the test into checkpatch.pl.
>> Should I write a check for this pattern or directly add strncmp into
>> deprecated_apis?
>>
>> > Actually I'd focus first on the actually broken cases first (sizeof()
>> > without the "-1", etc):
>> >
>> > $ git grep strncmp.*sizeof | grep -v -- '-' | wc -l
>> > 17
>> >
>> > I expect the "copy/paste" changes could just be a Coccinelle script that
>> > Linus could run to fix all the cases (and should be added to the kernel
>> > source's list of Coccinelle scripts). Especially since the bulk of the
>> > usage pattern are doing literals like this:
>> >
>>
>> Actually I am using a Coccinelle script to detect the cases and
>> have found 800+ places of strncmp(str, const, len).
>> But the script still needs some improvement since it has false
>> negatives and only focuses on detecting, not replacement.
>> I can upload it after improvement.
>> In which form should I upload it? In a patch's description or put it
>> in coccinelle scripts?
>>
>> > arch/alpha/kernel/setup.c:   if (strncmp(p, "mem=", 4) == 0) {
>> >
>> > $ git grep -E 'strncmp.*(sizeof|, *[0-9]*)' | wc -l
>> > 2565
>> >
>> > And some cases are weirdly backwards:
>> >
>> > tools/perf/util/callchain.c:  if (!strncmp(tok, "none", strlen(tok))) {
>
> I find there are cases of this pattern are not wrong.
> One example is kernel/irq/debugfs.c: if (!strncmp(buf, "trigger", size)) {
>
> Thus I do not know whether I should include these cases in my script.

That case isn't looking for a prefix AFAICS, so you should skip it.

I think Kees regexp was just slightly wrong, it should be:

 git grep -E 'strncmp.*(sizeof|, *[0-9]+)'

ie. either literal "sizeof" or *at least one* digit.

cheers
