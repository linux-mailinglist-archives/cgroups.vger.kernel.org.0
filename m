Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDA25B06F7
	for <lists+cgroups@lfdr.de>; Wed,  7 Sep 2022 16:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiIGOdo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Sep 2022 10:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIGOdP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Sep 2022 10:33:15 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1025B56D9
        for <cgroups@vger.kernel.org>; Wed,  7 Sep 2022 07:32:46 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e17so12405162edc.5
        for <cgroups@vger.kernel.org>; Wed, 07 Sep 2022 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=UTPjlhWN0j/3cl0uibj9IdU3K9tIHCNTd74bAPWV+BQ=;
        b=mqK4Urm6SI0LL0fIUpNglz2SbMFsznWTf0PUQzqjeQH/Bx12DkdTnBbzDZaQ4NR5iF
         EQ7O7aO6doj8u/y3juxRvQfrpZ+4GxqWxP8xLHHcNMflWyA+nbVtyNaPRhtr9ofPoPwP
         8B+OpsMdCo4QTDhmgZx918/MwMfvch/o8zTMSvXvdQRmqiXAGAGG0BMKFEwgydJ+Wh2g
         mACuo7ixacFf2kfjc0mw39zk8rxwdiQKq9VKx4zvYpa6O1ByXXOPP+qBaWEXo7gAHnwA
         FAVlPjIOEE2/ttEfWJe2qBCmRSUgsg0XQyoATWJy8k712P//auvk1V/Dh46aKaKpfIy+
         X5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UTPjlhWN0j/3cl0uibj9IdU3K9tIHCNTd74bAPWV+BQ=;
        b=wp6/d4R7fh5L8+kqiHLDFQ4sICm8eYRS7uDyqkfcktfUeDv7QHmc33FnLxKbK2JQyH
         cQeMNulo1k2GYaqvavB/UXdggcIOVPlKPk8EMbusSfZdgmwaYEHyUBPckPsGwDJyWnJl
         7BFaZv6yY4ym2eFxBFFhcJDbeFeCmMOb1O7up0XTjbk/6W3zPT0iBjsHVGZhfqZP6h2B
         a7yw+UacLoJMqjHocxzXB9eVN58Q50KBQuwchNkXQZA/nmWUvh6IyZ5sPRihRi7Bb8VS
         AH+vGcp48D2W8BpBtXH5C9KmDY5ioXkSHw7ya6+32utTGzWZBWegL0AeWBpO1tXYCaTF
         arEw==
X-Gm-Message-State: ACgBeo2z7+bOBQgYw4Ps7lDKwTK+vei9E6jKAm2t1KsNZ1V9UF0Kgkm2
        6wAyz0ujDSbz1jIUeeaPSS3siJDZxVMDLwijmgw=
X-Google-Smtp-Source: AA6agR4rVWBPLpn6GXYzkUIV6dVS5ftgYaJRvLA5IUNE2znvSte/lik1W2yhM2ubbwRHIY2/TUDyhZrg0vh1fMG2v9I=
X-Received: by 2002:a05:6402:510c:b0:43e:305c:a4d1 with SMTP id
 m12-20020a056402510c00b0043e305ca4d1mr3247713edd.35.1662561165041; Wed, 07
 Sep 2022 07:32:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:3fc4:0:0:0:0:0 with HTTP; Wed, 7 Sep 2022 07:32:44 -0700 (PDT)
Reply-To: lumar.casey@outlook.com
From:   LUMAR CASEY <miriankushrat@gmail.com>
Date:   Wed, 7 Sep 2022 16:32:44 +0200
Message-ID: <CAO4StN0TpPxKN5zH_svRaRqGX4qmv4BYo2qpgmikVSdFaMxdLg@mail.gmail.com>
Subject: ATTENTION/PROPOSAL
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY,UPPERCASE_75_100 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:543 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [miriankushrat[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 UPPERCASE_75_100 message body is 75-100% uppercase
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ATTENTION

BUSINESS PARTNER,

I AM LUMAR CASEY WORKING WITH AN INSURANCE FINANCIAL INSTITUTE, WITH
MY POSITION AND PRIVILEGES I WAS ABLE TO SOURCE OUT AN OVER DUE
PAYMENT OF 12.8 MILLION POUNDS THAT IS NOW SECURED WITH A SHIPPING
DIPLOMATIC OUTLET.

I AM SEEKING YOUR PARTNERSHIP TO RECEIVE THIS CONSIGNMENT AS AS MY
PARTNER TO INVEST THIS FUND INTO A PROSPEROUS INVESTMENT VENTURE IN
YOUR COUNTRY.

I AWAIT YOUR REPLY TO ENABLE US PROCEED WITH THIS BUSINESS PARTNERSHIP TOGETHER.

REGARDS,

LUMAR CASEY
