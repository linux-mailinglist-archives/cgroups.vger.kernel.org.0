Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0647E495
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2019 23:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfHAVBH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Aug 2019 17:01:07 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38252 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfHAVBG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Aug 2019 17:01:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id n11so71745055qtl.5;
        Thu, 01 Aug 2019 14:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=At1IZWoUrcjzoFBo6+pPU11vzH0qsCf+6x4oe65bvIg=;
        b=uStsrgDNX3A3NRNPBmsfEftPfszUtOF9JqpdBbxcAseb2Cp1nI6QJ4BVFu5H/rIZ8v
         rbzDuskZ1BvP68LPeL0zq8ZjO/V5OD40IDX9ZX4jz0s3j6TiVwylL6qxzXVjoGygHzq9
         NmtbEwgot5NskVLQwlSiyq0FuDuFiySrUDL+272PF2AvoPl6l1u6DBsQ8OlznD+uFli4
         4OHGxfrZaIQUIYT2PfKT1uatEHmlFCJQpUua+5gcsJt6g8M0BXkEO+QPsDrI1K3I16L/
         aTcKdJV9yk1ZrIuhzinYwy3k623M0pkPpqHfW8HbwvMAGxoiGTdSRxSA1LN1rg9S3KDA
         /nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=At1IZWoUrcjzoFBo6+pPU11vzH0qsCf+6x4oe65bvIg=;
        b=asO6aDk2EJl6o6j7nzIcbGXZsoLRDcw836K0s+GuGY6scCSEwGmDxGH0bLIo2PVm86
         nSPIEQCsk6RwM5QdqbBT6Vub3OS8U09Qc/YLytKlYmx/jEI3kwEPs6EqijIIcH/wZQP1
         i+RJ4mJPm6077rKDVnjujXSlAXo8OfSwhLzcZucfkKI7eYZhz/z1m2H69X+DxR6A8LkM
         NRIhoVUNSRN+DSeFZoOJ4FTYnh/phKcTiYVSWPTe3wv63UJhEr8ezPholZ+uq9imjsEv
         3YFxL0ZtvzJaZ4XvE/oyaTxsScjtak7Yh7sSsM7lueUuCM6hADCF/RAJocWhV/nzygwE
         iTnw==
X-Gm-Message-State: APjAAAVaPOCP/PN+42shtcnt9wWJbpgaPxOEtmVz9PjiDAO2iavuK76s
        YkP+eQmWKj2XhYzkLxnDB7ftgmrZZA3ZTXXfO4g=
X-Google-Smtp-Source: APXvYqx0U8hwjSfrfGv5PCv/q1e/Y06r9RaTrs0m4NDxmC1Gv/TW5z0Gt4fs9Rq2NhPg85DUKv7yZUyFkk37Ay5yXaQ=
X-Received: by 2002:ac8:2646:: with SMTP id v6mr91139076qtv.205.1564693265783;
 Thu, 01 Aug 2019 14:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <156431697805.3170.6377599347542228221.stgit@buzz>
 <20190729091738.GF9330@dhcp22.suse.cz> <3d6fc779-2081-ba4b-22cf-be701d617bb4@yandex-team.ru>
 <20190729103307.GG9330@dhcp22.suse.cz> <CAHbLzkrdj-O2uXwM8ujm90OcgjyR4nAiEbFtRGe7SOoY_fs=BA@mail.gmail.com>
 <20190729184850.GH9330@dhcp22.suse.cz>
In-Reply-To: <20190729184850.GH9330@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 1 Aug 2019 14:00:51 -0700
Message-ID: <CAHbLzkp9xFV2sE0TdKfWNRVcAwaYNKwDugRiBBoEKx6A_Hr3Jw@mail.gmail.com>
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 29, 2019 at 11:48 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 29-07-19 10:28:43, Yang Shi wrote:
> [...]
> > I don't worry too much about scale since the scale issue is not unique
> > to background reclaim, direct reclaim may run into the same problem.
>
> Just to clarify. By scaling problem I mean 1:1 kswapd thread to memcg.
> You can have thousands of memcgs and I do not think we really do want
> to create one kswapd for each. Once we have a kswapd thread pool then we
> get into a tricky land where a determinism/fairness would be non trivial
> to achieve. Direct reclaim, on the other hand is bound by the workload
> itself.

Yes, I agree thread pool would introduce more latency than dedicated
kswapd thread. But, it looks not that bad in our test. When memory
allocation is fast, even though dedicated kswapd thread can't catch
up. So, such background reclaim is best effort, not guaranteed.

I don't quite get what you mean about fairness. Do you mean they may
spend excessive cpu time then cause other processes starvation? I
think this could be mitigated by properly organizing and setting
groups. But, I agree this is tricky.

Typically, the processes are placed into different cgroups according
to their importance and priority. For example, in our cluster, system
processes would go to system group, then latency sensitive jobs and
batch jobs (they are usually second class citizens) go to different
groups. The memcg kswapd would be enabled for latency sensitive groups
only. The memcg kswapd threads would have the same priority with
global kswapd.

> --
> Michal Hocko
> SUSE Labs
