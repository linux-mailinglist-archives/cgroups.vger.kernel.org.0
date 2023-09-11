Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3EC79B7F3
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 02:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376391AbjIKW0I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 18:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244154AbjIKTPn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 15:15:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBBEF9
        for <cgroups@vger.kernel.org>; Mon, 11 Sep 2023 12:15:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31adc5c899fso5086526f8f.2
        for <cgroups@vger.kernel.org>; Mon, 11 Sep 2023 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694459737; x=1695064537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/sdkzsmQxQA0VmUOWu2qcGx46dyeNaTu7jP8u1Dy9E=;
        b=ukkIBmS919vl27KhRiuDqnNzkQ+5uAuOQR5w+ahaQlk7iF7L9jXvBM3zIipxykVlvD
         nBbFiMaHyjG8Ccyi9hKcSyaaf+5uYp8g/9E5odZ0r1QjiSBMDE5JFVGXGOZGMeYTRKut
         BQ4+H2sRMT8WldIzcH7qmvllFF1h+GBwKeWkz7qiteQ9Sl9UpTdscFclG1qXgvwGnJM8
         xh4Li8xwkqSzymkY6DIFtpU1oITAGbHkg2yzY5foeRXI0O4lzHnNZJmUBAOr2/vhUFrV
         18HjmeF4WzGjtRKQC4LFs7YSagXTEEAN8pKmd1JnpTVs+jf7/DT/faZxpcPbQNBAaluR
         YVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694459737; x=1695064537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/sdkzsmQxQA0VmUOWu2qcGx46dyeNaTu7jP8u1Dy9E=;
        b=a9xVjxCJejdPHgvoZddmVidvOKL6j7s90JG/1wmH1jhfQ5oXVjgqEPOBzo1iWsrQ17
         hVu3AxgGNowlFKaTLMmrgPw2F28ezDUsqGYyiamKb/4eOTtxa1c9zOj+yRzZkcQEJkp+
         elSZDWvl1CY7oSdeyU8IKnDx5m8c7FCvLf3lJ5q7Nzn1FWSrdMo4mPP1fW17s4vCc2HW
         np6oLAQpu6hY5dWmefZQk1AdE0EuTtP6vI6YEUqzspI9zZ+xsLT3pM5ShJXjq1dP1u+l
         wJJ+e8w6Fw6Bcg3xmrurwmcU6wfbZBzrZWvhtZklDg6z6cLZmc5BSlVSAYNoS8SIPKZ+
         IMBw==
X-Gm-Message-State: AOJu0YyumQT/+ymdi/cOgXZ4OT+K5WdbjZZgyOzMVAR63bgvDdUIDhPw
        uTiIkLcb/1Kn1lzF5KTxsjMHVQfAgcoxZCk7QZ4BHQ==
X-Google-Smtp-Source: AGHT+IEc67ZKE3rJgiPrC5giY388mjXip6QJSXMv3nGu3fNZ+6QKmhDUQjd6OI5V6IEfcJpRlwvW7MZlWCTSVnkKhJA=
X-Received: by 2002:a5d:564b:0:b0:317:6849:2d39 with SMTP id
 j11-20020a5d564b000000b0031768492d39mr9180136wrw.10.1694459736746; Mon, 11
 Sep 2023 12:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-5-yosryahmed@google.com> <ZPX0kCKd4TaVLJY7@dhcp22.suse.cz>
 <CAAPL-u9D2b=iF5Lf_cRnKxUfkiEe0AMDTu6yhrUAzX0b6a6rDg@mail.gmail.com> <ZP8SDdjut9VEVpps@dhcp22.suse.cz>
In-Reply-To: <ZP8SDdjut9VEVpps@dhcp22.suse.cz>
From:   Wei Xu <weixugc@google.com>
Date:   Mon, 11 Sep 2023 12:15:24 -0700
Message-ID: <CAAPL-u8NndkB2zHRtF8pVBSTsz854YmUbx62G7bpw6BMJiLaiQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 11, 2023 at 6:11=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 07-09-23 17:52:12, Wei Xu wrote:
> [...]
> > I tested this patch on a machine with 384 CPUs using a microbenchmark
> > that spawns 10K threads, each reading its memory.stat every 100
> > milliseconds.
>
> This is rather extreme case but I wouldn't call it utterly insane
> though.
>
> > Most of memory.stat reads take 5ms-10ms in kernel, with
> > ~5% reads even exceeding 1 second.
>
> Just curious, what would numbers look like if the mutex is removed and
> those threads would be condending on the existing spinlock with lock
> dropping in place and removed. Would you be willing to give it a shot?

Without the mutex and with the spinlock only, the common read latency
of memory.stat is still 5ms-10ms in kernel. There are very few reads
(<0.003%) going above 10ms and none more than 1 second.

> --
> Michal Hocko
> SUSE Labs
