Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC7550CBA9
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 17:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiDWPWP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 11:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiDWPWO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 11:22:14 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029814992E;
        Sat, 23 Apr 2022 08:19:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650727155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aW7jQR0KWBIkc4nx/X//lum8iJfo1esC27ROXDMIAM4=;
        b=tO1NY6Tjb52mvbTO2n1UoZ4ofdNFJe5Rn2F3aOr80/443JzWwjPwIHRZaB09H7e/SGTT+A
        DwxwMMOFZrWW7uiKMhXg/LEb0QHoJ001PDYSYQONXpFIWirG5EHMvcNcz4JIPAEkycaEAJ
        yYqK0l9Jyyn+PjxfPemSMfh0be1Ox3o=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] cgroups: Refactor children cgroups in memcg tests
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <20220423113037.gnfysktiuzmfnpmp@dev0025.ash9.facebook.com>
Date:   Sat, 23 Apr 2022 08:19:12 -0700
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com
Message-Id: <EEC47283-0467-4C97-AAB2-73F17A97CE15@linux.dev>
References: <20220423113037.gnfysktiuzmfnpmp@dev0025.ash9.facebook.com>
To:     David Vernet <void@manifault.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


> On Apr 23, 2022, at 4:30 AM, David Vernet <void@manifault.com> wrote:
>=20
> =EF=BB=BFOn Fri, Apr 22, 2022 at 04:04:15PM -0700, Roman Gushchin wrote:
>>=20
>=20
> Thanks for the reviews on this patchset, Roman. FYI I think Andrew already=

> merged these patches to the -mm tree. I'll send out a follow-on patch that=

> fixes everything you pointed out, both here and on the other patches in th=
e
> set.

The mm tree isn=E2=80=99t a git tree, but a collection of the text patches, m=
anaged by Andrew. So you can send a new version and Andrew can update it in p=
lace. It=E2=80=99s happening all the time: mostly for adding reviewed-by/ack=
ed-by tags etc, but for code updates as well.
It=E2=80=99s not uncommon for some patchset to mature while being in the mm t=
ree, this allows to include them into linux-next and give some more testing,=
 but without doing many reverts/fixups (Andrew is often squashing fixups int=
o the original patch too). So long story short, you can just send a new vers=
ion, especially because all changes all minor.

Thanks!=
