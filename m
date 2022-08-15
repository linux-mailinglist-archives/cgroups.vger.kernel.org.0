Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122315951B1
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 07:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiHPFKn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 01:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiHPFK3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 01:10:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C66D23D;
        Mon, 15 Aug 2022 14:17:19 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so7828843pjf.5;
        Mon, 15 Aug 2022 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=gWg73cYfI3vn4ljKPn4NYzrF9DqHWCnArM+29mdyT+I=;
        b=JdnWdzKSg3O1vPGcLmn7GlIHnJU/Z/J6io8Fo9ke8TmxNBQVwOYCBoi66M69jVhNAb
         +9wgMaaslDSuSEQUV5pfj52eY1qRUbZ/LS4Z9UwUHPjivwimi+teLl0IixZ77o7nKeaO
         dUnInH76iDFaiADer3fl19//dgpQ7cSvpFJAb2rPPVX7xS1S87WXZay9b3LRUOHqOar+
         xRF7l3DTI4EgW15ppokevTzJQTlke5q3Zm35MpdrMsOJq45vXPM3U8eswj6d7vgLeMhu
         uRJ5C4SKERyaTiDg7tN3KphglynvwlIZSAlXnAkUo/K1Zk5SR8+9WqhJVymF9vEN/TCN
         hAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=gWg73cYfI3vn4ljKPn4NYzrF9DqHWCnArM+29mdyT+I=;
        b=SVpTQPwQw5H6WappGElqMErDR9XYq8yqJQwpUx3j9/ymvqPTLe9QsO3xepERZ6dLe4
         Bf6oaf+Xo19vbM0DTjhVmWNc9TpMa8VWLn5KaXhHB0WZzrt2kOBuhJ9UQPl3S7M6nmH/
         1NJfSVcnueAYOOoSZ578s4u3AOOuQWIRBkyjyuyEYHA7pfU3I10wtxjyVG1+58IbQFFM
         zRBUdIEUFsTCrtFpRQsadDLb/4hWjFeA3WcrQLFgrXDzZvmHU5bOLmgGrrhJYjHGLaBs
         K1sDK/MdnTMsKkdLj88lW8W0IWlD8mVQi+JS2V/jz98Bu1FHHxbvz4l9GJ8e5sIoSjVA
         MH0A==
X-Gm-Message-State: ACgBeo2I0TfpXk3bmyw3qy1tFCm1MJw3ZLwbM2ItKJ0rBzAAacLliihV
        YF73idRaVyZPruo9dvKj1JHCZq9/kf0=
X-Google-Smtp-Source: AA6agR5mZ4yUj2OIUywAQUhn9sLjDDE0zs2XVNVDH0HtX3bSYz1GS4zEzTW7gZk/pWDAhRVVyQIj3w==
X-Received: by 2002:a17:902:c405:b0:170:88b3:c108 with SMTP id k5-20020a170902c40500b0017088b3c108mr19034977plk.172.1660598238617;
        Mon, 15 Aug 2022 14:17:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:3a69])
        by smtp.gmail.com with ESMTPSA id f7-20020a623807000000b0052acb753b8bsm6901114pfa.158.2022.08.15.14.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:17:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 15 Aug 2022 11:17:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Namhyung Kim <namhyung@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH v3 cgroup/for-5.20] cgroup: Replace
 cgroup->ancestor_ids[] with ->ancestors[]
Message-ID: <Yvq33G14AU0cuswB@slm.duckdns.org>
References: <YuQvcCrcgNWbtndU@slm.duckdns.org>
 <YuRJ7uzKY5/fokH5@slm.duckdns.org>
 <YuRo2PLFH6wLgEkm@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuRo2PLFH6wLgEkm@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 29, 2022 at 01:10:16PM -1000, Tejun Heo wrote:
> Every cgroup knows all its ancestors through its ->ancestor_ids[]. There's
> no advantage to remembering the IDs instead of the pointers directly and
> this makes the array useless for finding an actual ancestor cgroup forcing
> cgroup_ancestor() to iteratively walk up the hierarchy instead. Let's
> replace cgroup->ancestor_ids[] with ->ancestors[] and remove the walking-up
> from cgroup_ancestor().
> 
> While at it, improve comments around cgroup_root->cgrp_ancestor_storage.
> 
> This patch shouldn't cause user-visible behavior differences.
> 
> v2: Update cgroup_ancestor() to use ->ancestors[].
> 
> v3: cgroup_root->cgrp_ancestor_storage's type is updated to match
>     cgroup->ancestors[]. Better comments.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Applied to cgroup/for-6.1.

-- 
tejun
