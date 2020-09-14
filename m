Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE7C2689DC
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 13:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgINLV0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 07:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgINLUl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 07:20:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B21C06174A
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 04:20:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so18301601wrm.2
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 04:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kLfSmpZKw0IcWAbxwnk8PLqM8595LR3Odif7KTgUXZk=;
        b=NrVooSirCkC89uwDGsSlSp0zG/q+C1jxdMRgf5vGubOWhuYbiNfYYdydkZ3JndP3vc
         6j1Zt4R+v3/omPJt4fTsTB0b5IQG7u4qoZ9UkGKoveS0XQF9k1VBJIsF5vwqHnYw5nbh
         MlxJi+tdMfm8TSZbWKWyyv0HVCHtRKJeEg0u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kLfSmpZKw0IcWAbxwnk8PLqM8595LR3Odif7KTgUXZk=;
        b=njLz3GZiMd0E1nlgu4IfAriLhg28k4YRMmsP+1M6x1qSjbVl6m5Oq6ZomINIOtKEOf
         x1MRiYSUFwwfdCZGr+q+38l5oDHwBVWhas5L2wkGiW0nZ5ulImNmFb5pzAZBc74a0sRu
         IlChgAfgOpHNF6crDUI8GPCQaO8IIx2IKzbeV7mP9XqfjZEr+G4wiy47PG2nrPw7b8xf
         gIS3Od2I12nXZWvcKk/yj0kIkC5m+sgcq98XdJwZzEul46ZCv8FoHHp1AgH43MMRA8HJ
         yBtuLZWEUaS5WWso3btW8wzLhysdj+51QcOWNAcxfSH01jdFg5BWOdg8ECCnOD4vgJfF
         +gBA==
X-Gm-Message-State: AOAM530kkVL0jCpIT4ihyvt56pOMt8nodK3lgFNhz29s+xm/wp1c8JtN
        8GxMw1qPrAQr2VaKay3QCKTeGLgSe5FeGQ==
X-Google-Smtp-Source: ABdhPJwBJtsZXWlo/8DZ9/96K7Ym7PgHSobyj/KV5SR5J+lZjhcTVzvshIGxo/oQce5aFlYqWEXtuA==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr15342266wrw.325.1600082438340;
        Mon, 14 Sep 2020 04:20:38 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id m185sm19699575wmf.5.2020.09.14.04.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:20:37 -0700 (PDT)
Date:   Mon, 14 Sep 2020 12:20:37 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: Fix out-of-bounds on the
 buf returned by memory_stat_format
Message-ID: <20200914112037.GA2417148@chrisdown.name>
References: <20200912155100.25578-1-songmuchun@bytedance.com>
 <20200912174241.eeaa771755915f27babf9322@linux-foundation.org>
 <CAMZfGtXNg31+8QLbUMj7f61Yg1Jgt0rPB7VTDE7qoopGCANGjA@mail.gmail.com>
 <20200914091844.GE16999@dhcp22.suse.cz>
 <CAMZfGtXd3DNrW5BPjDosHsz-FUYACGZEOAfAYLwyHdRSpOsqhQ@mail.gmail.com>
 <20200914103205.GI16999@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200914103205.GI16999@dhcp22.suse.cz>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko writes:
>> > > Yeah, I think we should cc:stable.
>> >
>> > Is this a real problem? The buffer should contain 36 lines which makes
>> > it more than 100B per line. I strongly suspect we are not able to use
>> > that storage up.
>>
>> Before memory_stat_format() return, we should call seq_buf_putc(&s, '\0').
>> Otherwise, the return buf string has no trailing null('\0'). But users treat buf
>> as a string(and read the string oob). It is wrong. Thanks.
>
>I am not sure I follow you. vsnprintf which is used by seq_printf will
>add \0 if there is a room for that. And I argue there is a lot of room
>in the buffer so a corner case where the buffer gets full doesn't happen
>with the current code.

I don't feel very strongly either way, but in general I agree with Michal. As 
it is this feels quite perfunctory.

If you can demonstrate reading the string out of bounds in a 
userspace-exploitable way -- that is, you can demonstrate one can coerce 
memory.stat to a format where you would read out of bounds -- then we should 
obviously cc stable and keep the Fixes tag, but you have not come close to 
demonstrating this yet.

Otherwise, if you cannot provide any way to read the string out of bounds, 
because the buffer is simply way too big for this to ever happen, this is just 
a code cleanup, and neither Fixes nor stable are appropriate.

So, the question is, which is it? :-)
