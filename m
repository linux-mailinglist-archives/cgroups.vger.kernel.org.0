Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FE541BD61
	for <lists+cgroups@lfdr.de>; Wed, 29 Sep 2021 05:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243924AbhI2D1v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Sep 2021 23:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbhI2D1v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Sep 2021 23:27:51 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEB4C06161C
        for <cgroups@vger.kernel.org>; Tue, 28 Sep 2021 20:26:11 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id n17so1331775vsr.10
        for <cgroups@vger.kernel.org>; Tue, 28 Sep 2021 20:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mJP4XEW0PizZ+gaHwBJ6A7IE4TUjSS7IYV9gb2WrUn8=;
        b=GlTJjNKA9/XgQaTytLcy5VdmpOnq75ilyb1AI+A4KmRNdu9ilA5/NsO5+8D2vjw3TC
         UuJxskcL/h3N6hQxfGgFduD90pMpl8IfA752yrKkjPSDHaJN5Z7bL0j5Nrh+55u5buMS
         dMzG5pHaqsaekJnhQPB59NShFeyZIN81W79A8Gx5sB8K0y2nTgHYDAPpS7Q3akvBnTU0
         oMKWomDnSVs/KXb1tRoI3kSFBSAxuTzrkeRV9vi42Qk/W3Wc+l/mLI5bRrvwbydrs0sz
         Y+o8Hbik/F5DCpEkjh2zlEyYof7WLVevXX95RJBy/6+RSt1beGiQS6fT5/EpOHaV4JUE
         LPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mJP4XEW0PizZ+gaHwBJ6A7IE4TUjSS7IYV9gb2WrUn8=;
        b=Y2SGtMBt9i0H2ub7gsMlgP/lW+thsP+c2X+oly0wMzOHPTb6yZ2dKp4Ji0qv1uyD1P
         HuBDtqMWY/m5DhaTbqW4ijNE/q19ESHgSX3Jg0dAamRIVZenKYzpktlTPEJDttb8LrmJ
         F7/ctXY7jGvph5dTWoCoMdbCQkUlXmuZdSuQttxweiokpRP1cAWyf5BxSQnDAmIt9N2K
         F+jfdbd7BghpEFhWPec2wpbmnl8F2Y+UfbjKcBb8U/H9vlXcUnzJwp7LfhllNpA8XRV3
         3uHmi0QjlbMdBaLwkqTahU7btZzS5nnGAb3cQoLD1vKNzlw+oYkYi9P09Kb4qdjndoar
         Uiqg==
X-Gm-Message-State: AOAM533WaZCvKfyiFJiRd/8thTJh0cor1ugTVkBmTfbdD7dR70Mf3OLb
        TQxoyEPIMoxoSoX970UYOQCA1KwZk/AfuZZ55Kmjdeyd
X-Google-Smtp-Source: ABdhPJwrFJlk7pOcxzymFvvtlL8Yva15uSECGQTimRjkCiNaTctj8xvhv9FcHiIeVQxunHhJ3CJbWFtonkW2uVCIMVk=
X-Received: by 2002:a05:6102:302a:: with SMTP id v10mr7193325vsa.49.1632885970389;
 Tue, 28 Sep 2021 20:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHKqYaa7H=M4E-=ObO0ecj+NE2KwZN5d7QSz4_b6tXz2vOo+VA@mail.gmail.com>
 <CAHbLzkpBCQp7UGK_WPJ-akdQ7HqkOEMtE6+9qX5ciu3DU-ZVrg@mail.gmail.com>
 <CAHKqYaZAnz4wiHksKSZMLNEbk9eUUQ1z8iQCLwFgNW40ejByYQ@mail.gmail.com> <CAHbLzkpjRV_32V3AGCsDku8JckeFKvEWd=w2-ZkQ2hbcOAChAA@mail.gmail.com>
In-Reply-To: <CAHbLzkpjRV_32V3AGCsDku8JckeFKvEWd=w2-ZkQ2hbcOAChAA@mail.gmail.com>
From:   Yunfang Tai <yunfangtai09@gmail.com>
Date:   Wed, 29 Sep 2021 11:25:59 +0800
Message-ID: <CAHKqYaZj1wB9GU9kWhNTpxJ-2xypxw5_6PzHrS1r=mJ3MQxwOA@mail.gmail.com>
Subject: Re: [BUG] The usage of memory cgroup is not consistent with processes
 when using THP
To:     Yang Shi <shy828301@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Tejun Heo <tj@kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Yang Shi <shy828301@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8829=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=886:14=E5=86=99=E9=81=93=EF=BC=9A
> I don't quite get what exactly you want to manage. If you want to get
> rid of the disparity, I don't have good idea other than splitting THP
> in place instead of using deferred split. But AFAIK it is not quite
> feasible due to some locking problems.
I get it. Thank you for your reply!
