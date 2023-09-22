Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550DE7AB8C3
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 20:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjIVSAP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 14:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbjIVSAD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 14:00:03 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47437CCE
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 10:59:55 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so43031701fa.2
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 10:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695405593; x=1696010393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neFKDss4Eoz4zqBDkZFgiJEWmdfT57VEWXtM0Jgtcu8=;
        b=NO2GxxrARKtVZOSuIAMt9Ix6EPjYW5hGkY5KMhlhPvlklZuBBhdfW3kQzC5UIS0Gcu
         noUJVp1dkiwSLCuovsS6cydQnDXH5XO0oIM8TJa8aHmqSkWc0U4djBl2EYpwmbdTenLW
         vcxon6A//JrFRuM567ICtp58sVYzH8TcEqvFnfhqISxB/TlRsu+WI0S2TS8QM2H8sJzG
         daE25I68Iq6ByjiVUOX/McVVxqTLPVx+wNqyzVrYjk3mtwbMlk7VZtjfSvuX6jdrEtlv
         jaNpj23Rwq3D197kfypZs0chiG70X45KWoPd8usq1ljHbZxU6qyxmR9Fp46Kd0XMX9Vs
         ToCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405593; x=1696010393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neFKDss4Eoz4zqBDkZFgiJEWmdfT57VEWXtM0Jgtcu8=;
        b=U5vMQxnYQPvS+IcF8N8lwUisUHGgrTR29qDNPRxnz3GAe3TkI8+7+S2LQJDZxBaEMi
         ZduCsTGWuJWo9I6fGYicatGeViqiKeAdFeNRRzg4F+1ETETrY+2kvGOIzzP7qA+Dv60y
         Cpk9dCGQzOF98tLuVEd1Qfav5SJdseQZmzlue4sVybs++cK1LouRqAkVmsN+5P1+pWTD
         GfYokyerm8uD+rWr/Zzvug3TrW1ylPKk5xEzNuw7vG6jZel1H+/IR9CHB89QHToW+Vwh
         Po6dn8w9f5iprevOk8DKu+B4lAjowvsIY6amksoDrSUXhx6tlt1UuTCfIK6s7zXxu7vO
         VlfQ==
X-Gm-Message-State: AOJu0YzAhZgUuEEc3bt+cb198ag2S8JsyGWdlilQ/i/oOrgWatW91iyJ
        QncL7hFUbLYgNJQ604Q6nEuuLF3JIQNeM1VYq4OouA==
X-Google-Smtp-Source: AGHT+IELut1xHfbiwqDVm6Sq/3W8KL4RFEb3KaEJoxNiOhq0MLqeWIIK2Jkfl56eDAdwP2sEzoc2VncrFBFuV7o/z/g=
X-Received: by 2002:a05:6512:2512:b0:503:8fb:f738 with SMTP id
 be18-20020a056512251200b0050308fbf738mr259391lfb.17.1695405593333; Fri, 22
 Sep 2023 10:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230922082542.466579-1-yosryahmed@google.com> <20230922100310.102aa12ac2bdf0568e6e7432@linux-foundation.org>
In-Reply-To: <20230922100310.102aa12ac2bdf0568e6e7432@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 22 Sep 2023 10:59:13 -0700
Message-ID: <CAJD7tkbHcJ59XLk1VqhkLtuZOqqw=VQyCqB1eooy6hR7eb3RSQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: memcg: fix tracking of pending stats updates values
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 22, 2023 at 10:03=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 22 Sep 2023 08:25:40 +0000 Yosry Ahmed <yosryahmed@google.com> wr=
ote:
>
> > While working on adjacent code [1], I realized that the values passed
> > into memcg_rstat_updated() to keep track of the magnitude of pending
> > updates is consistent. It is mostly in pages, but sometimes it can be i=
n
> > bytes or KBs. Fix that.
>
> Clashes with "memcg: remove unused do_memsw_account in
> memcg1_stat_format", and maybe other things.  Can you please redo
> against mm-unsstable or linux-next?

Done, sent v2:
https://lore.kernel.org/linux-mm/20230922175741.635002-1-yosryahmed@google.=
com/

Thanks!
