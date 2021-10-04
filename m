Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFA1421696
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 20:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhJDShP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 14:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbhJDShP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 14:37:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3434C061745
        for <cgroups@vger.kernel.org>; Mon,  4 Oct 2021 11:35:25 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x27so74988860lfa.9
        for <cgroups@vger.kernel.org>; Mon, 04 Oct 2021 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3rtjAMF0s155PLuGLifQ498nM8uqHQjjd2W39f9bKM=;
        b=dNO+T06bp6n0e4wCqt2yTEMB3F80fM9Vgzh5jpZIO6mwe3DQMRXOaOdLXC2M1lh9Dq
         mE8zj3N4kaJpFMlMmObQxrMYzYFijF3w/RodiCCzivMxJEkMGTHT9reE2Z2XmAQUHNUB
         qBSFXy+3wiqJxSgNsmPxHifuceiJzF4H8lZLVfvrvY1Xk8lF8SdxcV9M8EtOmN0tT0c6
         LSwA2ZHu9+qtrj9c/MDnNYT3a/aS6l3z3CvSBMjGEDRnzK9LjpdHqL57qmotS9zmJekZ
         zyiWkTFDoth+KvmXIYzXgu+DnWmUElPhq7/W47WaMfHA7Sj87eZwJEUkCSy+IPjbnlDL
         ud5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3rtjAMF0s155PLuGLifQ498nM8uqHQjjd2W39f9bKM=;
        b=JEu2HsJjJJOQCjI5MsPRZjNYV+aqJS/mXDTaoVsqwVaULTtiixS85tFNxzscmKlM2g
         DAPaMck43cXseVyRZdxhRi6tMBKk2GPweGcykxnfYVLQS+c/JC/6GvICeBhXDKkgrzPt
         ovwEkSmK6gls7uwdqSlHxWtJi7XRTgxsZFxumfZRGYIbZ+ZCcoXAv+b8hbGyw1uxtcpG
         FzZnVNlqbcAJD/zXyYpao8sjy4t9KoTYV4ojO1JyK4hApRpP0v6ccJYhq580PMW1F4fh
         yMMPizDA3D7fhh7A+geBA1cf2oef9+9hu8y+arYAuLaoMstqjWs8maBBU/MjHbJowHOA
         pUsg==
X-Gm-Message-State: AOAM530w2h3zlzCjYTfHLCLeNVNIBGJdarVa/0CLYjAOQHpwq5faNxsJ
        B1i4GfEqrZ2/N96UgcMZXCrhcBhp/nC9uFo7rQghbw==
X-Google-Smtp-Source: ABdhPJzQoBkAHyXUeQ3KnJgIm3rCI51rSjZj0N5KHvvzay3sVbDvaiAdddgWewCFSNbRXzhME17MIseGyg8Li5GWMNk=
X-Received: by 2002:ac2:4157:: with SMTP id c23mr15601352lfi.184.1633372523869;
 Mon, 04 Oct 2021 11:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210929235936.2859271-1-shakeelb@google.com> <YVszNI97NAAYpHpm@slm.duckdns.org>
 <CALvZod5OKz=7pFpxCt1CONPyJO4wR5t+PH0nzdbFBT1SYpjrsg@mail.gmail.com>
 <YVs9eJnNJYwF/3f3@slm.duckdns.org> <CALvZod47r=9j_MhZz9ngWv_JE4oqF1CrXTOQ2GpSSNFftZAsVA@mail.gmail.com>
 <YVtGHoboSix3rexr@slm.duckdns.org>
In-Reply-To: <YVtGHoboSix3rexr@slm.duckdns.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 4 Oct 2021 11:35:12 -0700
Message-ID: <CALvZod6fwur--Q6Kh6GSPRR_16DQdrNDyuZgYjgncDpPUENWVg@mail.gmail.com>
Subject: Re: [PATCH] cgroup: rstat: optimize flush through speculative test
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 4, 2021 at 11:21 AM Tejun Heo <tj@kernel.org> wrote:
>
>
[...]
> What do you think about that approach? While the proposed patch looks fine,
> it kinda bothers me that it's a very partial optimization - ie. if flush
> frequency is high enough for this to matter, that for_each_possible_cpu()
> scanning loop really isn't appropriate.
>

Makes sense. I will take a stab at that.
