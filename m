Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 820C1EF32
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2019 05:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfD3Dcz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Apr 2019 23:32:55 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38943 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbfD3Dcy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Apr 2019 23:32:54 -0400
Received: by mail-yw1-f65.google.com with SMTP id x204so4888184ywg.6
        for <cgroups@vger.kernel.org>; Mon, 29 Apr 2019 20:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWEKtGsRIMq4v+NhZemcUNWB8/vTGODLsuHGIZCvLns=;
        b=DDDpEVSRE8oPO+cOinkkQ7lINMkV8y8Sp8Tp7Uttz0QF6r5bQ6+/3ePMNmPLDpz7rI
         KPala0XBYAmQ3SePPZ40hYTg86geNQPy2Grc0K4z4RE6whwqluCHezd1NGgB6rfucnUg
         hV0HXKuk9r2hCL9OuhfjFrDv44ufG3YiG18/uldGmxv/21HyO0kCQVr3yLGsWLB7fOC3
         SkopmmTFkLYAnVdS9QIFL6GJf2lX9LAxqwQPzB+5TwzDX+vkYdax3NVP1fpz6XxoBOlo
         7+1lZvseE7ID/p1TWU21NN5jMaEzewo6ONCu/nBDNYNpYsDUS9LKTnK702xr83iKOnNl
         XqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWEKtGsRIMq4v+NhZemcUNWB8/vTGODLsuHGIZCvLns=;
        b=uO28iqb8L1FQHYiVOt/ufNMms5L9XdgYSLtzkhYWc2L7SQq/isKkzczo8Wo6E0lmbW
         CDQzoDiDwpTy48+kdsNfZnZQa6/mhtSGJFR43fo1wBtBA0e69dOJtrWbeIDjL6n6ZVWp
         5Obhvt0RmNNiRDri7tn2KKJfa/pvIYiB/UbZch3FytmacM+S84OoX7kXZsydiTMj8Ngb
         om/jU1F/d+x0MdCiJ1y9ixGjNFFRy4XF9ZTYJgcTez/F/gVw+uZQ+u8jeHs8stdbcLEP
         m4OYJikhRYCJTX5teT1JYgvkhFiRdPBbmWrsvGJ9Yt0Y+HgYPxt4+0b8XhIzJcp6km1i
         gO1A==
X-Gm-Message-State: APjAAAU7wiIc2WBBzd52KjdWV640JsoD5sqNHd+LKklmKG/E4WJ05XUN
        RmnDlfx5SOxnxAyQYiRgTkTBh46RVgL3oZOy9e59Hg==
X-Google-Smtp-Source: APXvYqxiTSC6H3uYqE0DoAstpjwFGHHohchbO4x8XQqIAb6J5UkRzE8VEEfSYh/QD37Z8jEdNZRckmYBonsmWkkAg2k=
X-Received: by 2002:a25:f507:: with SMTP id a7mr52256523ybe.164.1556595173714;
 Mon, 29 Apr 2019 20:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190429171332.152992-1-shakeelb@google.com> <20190429171332.152992-2-shakeelb@google.com>
 <20190429214123.GA3715@dhcp22.suse.cz>
In-Reply-To: <20190429214123.GA3715@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 29 Apr 2019 23:32:42 -0400
Message-ID: <CALvZod5uXOQfeq9_03T5dv104tWwuukL0+vEAVhk-v1_A=skQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] memcg, fsnotify: no oom-kill for remote memcg charging
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 29, 2019 at 5:41 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 29-04-19 10:13:32, Shakeel Butt wrote:
> [...]
> >       /*
> >        * For queues with unlimited length lost events are not expected and
> >        * can possibly have security implications. Avoid losing events when
> >        * memory is short.
> > +      *
> > +      * Note: __GFP_NOFAIL takes precedence over __GFP_RETRY_MAYFAIL.
> >        */
>
> No, I there is no rule like that. Combining the two is undefined
> currently and I do not think we want to legitimize it. What does it even
> mean?
>

Actually the code is doing that but I agree this is not documented and
weird. I will fix this.

Shakeel
