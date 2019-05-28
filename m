Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93BD2CDB9
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 19:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfE1Rhk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 13:37:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46404 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfE1Rhf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 13:37:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id l26so15250079lfh.13
        for <cgroups@vger.kernel.org>; Tue, 28 May 2019 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2jMeMvfMZ6+f8aMiqek9ZN+qjHWyjCaTe5iI/rDq+E=;
        b=F1ETGdXeFfCBHmdWbLBHd8vZ7taVOvI6ORkmxBqkgmnSIzcWwbuL7Fhv0S2FLp97AT
         XCPInppgu1tkfwt4dcLiPmzEju6ML58hvTfKMWoxMW2Wuusd11zPUwBSNYNdyPwqwnst
         6LPs3DuCLXNIyE4Zp2se+L+KeAMs1gw7ROLd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2jMeMvfMZ6+f8aMiqek9ZN+qjHWyjCaTe5iI/rDq+E=;
        b=nzEiiizOnrGdaiJXCKez5vAGOH94sEtVkvk/8z7vmYRohgoMYm0a8PSWl3QYPoO4E/
         GCU6lcM635fnfA34/WizLzegZ7ZaMUSV+b4mGjY7UE077c1F0rU7kZwFGjIuyEKY4OUL
         5LnqxtKiU8axenR42eNv90beBlneYl4W3DsvURU3pkHeSQ4vld4LEg+cgn7OhSnf/t7f
         h/Q8U9CM0N99fD9N+bXrYb8K5G2RWGkaqeLTM9TmPT9lSlYyVGt78zSwn5PR1nINt2Ux
         Wg7EFXqgakhsrNtItOcHdtJU5euXqrzK/ywcIB7RQFzU3keH5GS4rEYXnOPwxgOr5rZP
         su0Q==
X-Gm-Message-State: APjAAAUucTZtfdgs3XzWWvxkGNiH1+N2YXchfR4hVrLfYQFmKEZ2OlFR
        8SYwf08ccVc9I+I2hd8Y4k7492Dy3T0=
X-Google-Smtp-Source: APXvYqwGu5sml9g3Pj9CWZJGQnuYS4BgUlJth1/REojhoS3hmVEyPszxRNSwoUXWXbzaemLYn09BKQ==
X-Received: by 2002:ac2:5467:: with SMTP id e7mr1430870lfn.23.1559065052902;
        Tue, 28 May 2019 10:37:32 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id e19sm3038897ljj.62.2019.05.28.10.37.31
        for <cgroups@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 10:37:31 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 14so18542977ljj.5
        for <cgroups@vger.kernel.org>; Tue, 28 May 2019 10:37:31 -0700 (PDT)
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr49489655ljj.1.1559065051361;
 Tue, 28 May 2019 10:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190520063534.GB19312@shao2-debian> <20190520215328.GA1186@cmpxchg.org>
 <20190521134646.GE19312@shao2-debian> <20190521151647.GB2870@cmpxchg.org> <CALvZod5KFJvfBfTZKWiDo_ux_OkLKK-b6sWtnYeFCY2ARiiKwQ@mail.gmail.com>
In-Reply-To: <CALvZod5KFJvfBfTZKWiDo_ux_OkLKK-b6sWtnYeFCY2ARiiKwQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 May 2019 10:37:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaLQjZ8AZj76_cwvk_wLPJjr+Dc=Qvac_vHY2RruuBww@mail.gmail.com>
Message-ID: <CAHk-=wgaLQjZ8AZj76_cwvk_wLPJjr+Dc=Qvac_vHY2RruuBww@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: don't batch updates of local VM stats and events
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <rong.a.chen@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 28, 2019 at 9:00 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> I was suspecting the following for-loop+atomic-add for the regression.

If I read the kernel test robot reports correctly, Johannes' fix patch
does fix the regression (well - mostly. The original reported
regression was 26%, and with Johannes' fix patch it was 3% - so still
a slight performance regression, but not nearly as bad).

> Why the above atomic-add is the culprit?

I think the problem with that one is that it's cross-cpu statistics,
so you end up with lots of cacheline bounces on the local counts when
you have lots of load.

But yes, the recursive updates still do show a small regression,
probably because there's still some overhead from the looping up in
the hierarchy. You still get *those* cacheline bounces, but now they
are limited to the upper hierarchies that only get updated at batch
time.

Johannes? Am I reading this right?

                   Linus
