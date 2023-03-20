Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CA86C10F2
	for <lists+cgroups@lfdr.de>; Mon, 20 Mar 2023 12:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjCTLi3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Mar 2023 07:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCTLi2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Mar 2023 07:38:28 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CAE1448D
        for <cgroups@vger.kernel.org>; Mon, 20 Mar 2023 04:38:27 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id c1so7421527vsk.2
        for <cgroups@vger.kernel.org>; Mon, 20 Mar 2023 04:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679312306;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4kWzn6pxkecn7JMiXg/VymW/f2W9szhFxBJtG2FdMw=;
        b=M3Z/ga0yUjls8h82yHnCxWe0I9CAOuB9T9PJgEp4KBMxwHroT9HL1O/uzrcv3G3JiB
         JiTdG6uVLIkjqvBEv5tpxVKW32Gjj6V288CSAopn9ZyiUmXdO85D5/gdvMZmF7FloWeN
         NDoBqlQIqidMOKE/KQd3MfbPcupVJTD4+qrt41HiKYsdOb/Mwvhhg0/4Vwq8cTqMPE+U
         1/Ugp22WRWMiPrDPQmRQBUqu46C2uLHMf6NFVtcZ6Fs5SLMyAhye/LPoQQoHCp37A0DR
         619v0tvJ0n4gu0tjN1n+PKYwq9zUoJRpS50s6loPY9zzuec/P5YxoVyhmd8XlVmbB5bd
         XhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679312306;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4kWzn6pxkecn7JMiXg/VymW/f2W9szhFxBJtG2FdMw=;
        b=ImsgGjT4LnRtu0TBVfCwxnHHPWmAJ5CscAgPJpoaLZsOiV/PDfx0xUgQwHChuXH4xW
         i2fDMuTIp2ta6APh4OzKiXLsiRDuGmpg9+FJ1Yljh/WNzES4/oCKdLracovDLjRY7fyG
         n0Ooq/go+vTmsFBdYv1eoTXca0OGdSVjrnfdt2+IJI3+W+xSkHzoJo6lx8dMaFfn3cfL
         sPhKsLI91BdLS9cQ431oxvi4qMrJkbMTXhQaXKOk88l4uIZFbj/GZCXWe1bmOmteQaoK
         Y/gN2m2ozqvEM+KOcNu+L73eHzrrRKwGGwou6qEbWZ2R7l6jCZ8R3HbWhELDDAEt8K0e
         okOQ==
X-Gm-Message-State: AO0yUKXdowSDtDObWr+F316kRFsMMlnxPKdNN2mZ61l8ODjEHMBCfBTD
        1C8bGodRRDuCA1kwpxvjzEoP2p5dzMQZg5aDKbs=
X-Google-Smtp-Source: AK7set81l1BzxEkukKw3ORxSrI7TQLxhd4b4tKzKW1MFQqEhd4s5hSDEnLMAZn1mVstvjnPzHO0/jSnrGTCmISc8bv4=
X-Received: by 2002:a67:ac0c:0:b0:425:8e57:7bfd with SMTP id
 v12-20020a67ac0c000000b004258e577bfdmr3579877vse.3.1679312306642; Mon, 20 Mar
 2023 04:38:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7a4a:0:b0:747:a875:ea9e with HTTP; Mon, 20 Mar 2023
 04:38:26 -0700 (PDT)
Reply-To: contact.ninacoulibaly@inbox.eu
From:   nina coulibaly <ninacoulibaly81.info@gmail.com>
Date:   Mon, 20 Mar 2023 04:38:26 -0700
Message-ID: <CAJws7AAEcN=Wx4G-Z2TAK9xuA6pEAwmRvLZEOXQA53YBMKdDXg@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear ,

Please grant me the permission to share important discussion with you.
I am looking forward to hearing from you at your earliest convenience.

Best Regards.

Mrs. Nina Coulibaly
