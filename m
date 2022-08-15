Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C070A5929C8
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 08:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiHOGpu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 02:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241026AbiHOGpq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 02:45:46 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587C4BC8B;
        Sun, 14 Aug 2022 23:45:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660545943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qBCWO3lIwWMGpb/gijq8ucNqW63ks472vIwnDJtW+J0=;
        b=ELwW0r/CQ2nOs1I8nSNLZ9BeOE68kOpgaXhZuIZEC2ubQ/6/bFT/x1Exk3nONz4uJosbg1
        iHz9UF/cSI/z7ScjXCnupqYT7f3mQ6Rg4XjN76W1xTR3LN3OHKQQs+vW7CtYnIZXAZfdyZ
        vZ7SN2/simx1lOSk1BgnBuWRdc1dX94=
MIME-Version: 1.0
Subject: Re: [PATCH linux-next] mm: memcontrol: Fix typos in comment Fix a
 spelling mistake in comment.
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220815061208.65945-1-xu.panda@zte.com.cn>
Date:   Mon, 15 Aug 2022 14:45:27 +0800
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, xupanda <xu.panda@zte.com.cn>,
        Zeal Robot <zealic@zte.com.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <163DC765-D629-4BF5-8A3C-9146BEC6748D@linux.dev>
References: <20220815061208.65945-1-xu.panda@zte.com.cn>
To:     cgel.zte@gmail.com
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Aug 15, 2022, at 14:12, cgel.zte@gmail.com wrote:
>=20
> From: xupanda <xu.panda@zte.com.cn>

1. Your subject seems to have redundant description.
   =E2=80=9CFix typos in comment=E2=80=9D vs =E2=80=9CFix a spelling =
mistake in comment"
2. It is better to clarify what you have changed here. Like:

Fix a spelling mistake on =E2=80=9Ccgruop1=E2=80=9D.

With this:

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.=
