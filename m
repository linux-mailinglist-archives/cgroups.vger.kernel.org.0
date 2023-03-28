Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E266CC409
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjC1O7j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjC1O7c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 10:59:32 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223E7E077
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 07:59:18 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p203so15388362ybb.13
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680015555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/Tr76xWiRdPhCzh2iAIz1ngMVJemqmUsrV57MPqNeE=;
        b=Tt1MpwBCckGfBRJPyJn7mnYIufUfVxu0osm9Xuq8gDBzp9Zl5SijHD6x4KQjbrMWEh
         cR4itExVYXUY8HTQuYCWuV5Rg6H125SdaHSCPAvUlKamplxStCH4rjE2/WcnHTjKhjrt
         038rfwwfndQ2ou7fJtK3qBflN/A1iDRlkq81JX+Z7insN5nb1uTL0Uo01n0XraIao7M2
         Fdp9ucU3Ljn6qpuDyKhjPEtSctWImYf+1VP6nPOE2U4SSXgKWYIn4QDlVxtNK1zY5mgr
         bLTFWCgmCGlE6IuJslMe1IS18hr0AuFjkuVwxblk3dP0+AkaQl8W95dVHmZXdHKaN7fx
         PZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/Tr76xWiRdPhCzh2iAIz1ngMVJemqmUsrV57MPqNeE=;
        b=o2Q5wSyHw5NVt4YWG1AgtwKTpHSbKmqjxrcytAKUIj+zCTqZI+/T2lAkjPr9rGgXhD
         IWmb/jwzas+MGLyZ3G7mv/nHXRjVy5A2sAWH9UAiiU5dx7AxVViYJykzQyZ9in6CpgZI
         GdVz08OrC3Y0cB7yMKTs9/IRNQvASml4aLdsBwQ1tZXBD/IOa+UtDbIo0My7n9l5OZoP
         BSyo/l0wU5Xwhcs93X0qLv34Ph+xR4xexPiaatNe5g776krPQGpq9jsF5VpSKM8SCT1g
         kwa8ILWsCNNia9tKi/57zymeO1xEbwRuDb0UzPbpoR1h4JPaRJoNwXnJM8ebu+uNwb2s
         zYnA==
X-Gm-Message-State: AAQBX9eYaI7PIKtsRY8RT7GYOeKKKBtMTbaz55gUIVgK/ARcINHs58fW
        AZKvpmS7p2XcNsnGufWadIDl3bfEFAMH2Rpfb4UDgg==
X-Google-Smtp-Source: AKy350aNQtresOYs68OKsUS0vcF2N6XmOyJ60HmYb6YXhXcoQU+dKlCLTm68Gcz+3vaqlOs4fNhYSgxXyk+d8mzAE3I=
X-Received: by 2002:a05:6902:1108:b0:b6d:fc53:c5c0 with SMTP id
 o8-20020a056902110800b00b6dfc53c5c0mr13259448ybu.1.1680015555044; Tue, 28 Mar
 2023 07:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-5-yosryahmed@google.com>
In-Reply-To: <20230328061638.203420-5-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 07:59:04 -0700
Message-ID: <CALvZod4zLhgjd3Tr5Qauz+OwF7Gj-NwDZPMpYAsxaMSUvu3F4g@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 27, 2023 at 11:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> rstat flushing is too expensive to perform in irq context.
> The previous patch removed the only context that may invoke an rstat
> flush from irq context, add a WARN_ON_ONCE() to detect future
> violations, or those that we are not aware of.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
