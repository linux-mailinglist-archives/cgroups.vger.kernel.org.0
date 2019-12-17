Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20B3123065
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 16:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfLQPe5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 10:34:57 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42333 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfLQPe5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 10:34:57 -0500
Received: by mail-qk1-f195.google.com with SMTP id z14so8567811qkg.9
        for <cgroups@vger.kernel.org>; Tue, 17 Dec 2019 07:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=WIcgHN30dR2crDNHrX3sAimvrkTmgj4IY/+nrOsfb9k=;
        b=PywzVWBsXibwF9hDhJCdPW2VL32SQKqTUSKd6D+9UIqoIV7pmnlbaOJ+qTm0m1E0uT
         zFgW0p2F9QnGu1M/DylWPZyV5hnHz7D+ap0nWhNkLi86F7Q3MwF5Kbll87NdUFwBqgWX
         wXv0O7g9neyrEpeGc6JNk9zpV1O7hOjyaDdTtePzsVisZH/y5QHKU890sIAYZJ9TXJsz
         Zr/T/HpH6iUXsgmwVIILdLkrupJGp6j8eHGk2ibc3KSXeDV67Lr2jTB05m6geLtaJcXr
         UuumkHs7gyxZeREiJ/AOjM8DSejbrBZvtPQRT3oVIWlugpNoxcFSHGMhQCfMKr4QF7mE
         GdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=WIcgHN30dR2crDNHrX3sAimvrkTmgj4IY/+nrOsfb9k=;
        b=Wp9JUMsULuz3xbmzm8dzM3KdqEDkGP+SN4EInMuCqUc/N89TMVJHOt4pF0aqzJkcd8
         Xtlo2Y8Vd5mQ8F+FmGYkEc97oXyng6gIeXrj9IzAcVH+x4DSyKflQnicSwUE4cyaqelg
         jW1ilg/iTFN/Ipk07ypCo+QNY1F4xhyX7i4WDEfaOsUIyLjh5F2m0XXHCXj9GR853kBK
         5CKMh7HY+BwofG9ZGjHE5iZpvYzhBnlUE8+E5NcrSQd/jcpZlYL8yJXxHYGsF4BmRJdn
         4BdHNmMIySuoAIjJzrKrDCbsdFRchBP0HHfYVyYTl8YppR9tamKPoyHmGSsvBSlfpks2
         el+Q==
X-Gm-Message-State: APjAAAV6ZjhsTwkq4poEWhrei844fw+cc+ekzZbqmc6r8UeV55PNbq2C
        xj/vlMj1GYrkAcSolfHHmgCcBg==
X-Google-Smtp-Source: APXvYqwvEuSRz1JrJXykeUpICkmJqlku5cTmZZfJ3EItoZnLotOClF6h+hnfPLEg0+oc3Xm2j+KD4A==
X-Received: by 2002:ae9:e206:: with SMTP id c6mr5684828qkc.105.1576596896651;
        Tue, 17 Dec 2019 07:34:56 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a66sm7220772qkb.27.2019.12.17.07.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:34:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under CONFIG_MMU
Date:   Tue, 17 Dec 2019 10:34:55 -0500
Message-Id: <CE79F821-F17D-489D-81A9-CD87AEA9C0ED@lca.pw>
References: <20191217152814.GB136178@chrisdown.name>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191217152814.GB136178@chrisdown.name>
To:     Chris Down <chris@chrisdown.name>
X-Mailer: iPhone Mail (17C54)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Dec 17, 2019, at 10:28 AM, Chris Down <chris@chrisdown.name> wrote:
>=20
> Maybe Qian is right and we should just ignore such patches, but I think th=
at comes with its own risks that we will alienate perfectly well intentioned=
 new contributors to mm without them having any idea why we did that.

Yes, that is a good point, but in reality is that there are many subsystems h=
ave already done the same. We even have some famous introduction document fo=
r kernel development put in the way that if =E2=80=9Cthe maintainers (or Lin=
us) ignored your patches after the resend, they probably don=E2=80=99t like i=
t.=E2=80=9D=
