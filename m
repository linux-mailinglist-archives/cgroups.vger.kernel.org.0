Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FAC54C518
	for <lists+cgroups@lfdr.de>; Wed, 15 Jun 2022 11:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344496AbiFOJt4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Jun 2022 05:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241474AbiFOJt4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Jun 2022 05:49:56 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A394C483AD
        for <cgroups@vger.kernel.org>; Wed, 15 Jun 2022 02:49:55 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id n4so11386990vsm.6
        for <cgroups@vger.kernel.org>; Wed, 15 Jun 2022 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=YNz0WEVLaqTrfyxkKfpDgGRYngFf7pW3wfCRYEeYeKA=;
        b=eJELUllqV4lRM2ThqyNuJULAZPWJLQj79j8/9MfhBsgtmWL7dgFeUWhXwXGDWNnGi4
         QKCswNfx/XltmapNLNKPWgngh3W/Na6WwY5aBR312QV+xztHkOO7wV1AglImzh5MryoN
         gOEAvHOJjqajMcQyQd7gtKCFPodmgDv7IB0sHJeQeOzogw3JBSCw1LwtmvueQj0MCN+4
         yP7as/a6LK6AFQRpClxhKTdXDMmYe1ju3x88QOHhJGl1oxsChVaskdwF+E+Lj4OPeZId
         tWK0SUNc5YiC9QTFJ0Yh8A4bfXmwQv77O7kNXXf+JyEeor9tvCtvbp/BTKt65KtnIiOB
         bEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=YNz0WEVLaqTrfyxkKfpDgGRYngFf7pW3wfCRYEeYeKA=;
        b=CeJw4+XhlrMXTI9AMp1qbNlDGY5pMNj81ApUM9R3cYGi35MwkvuCQZbnKlizN0TUhq
         v0kxWGt1bJvQUT4ll4rLwmgYs+85u7otkW0ZIxDZSPqQLjHqCwNGDIFJ1iiP5miSuTYP
         pVlGhaU8jthDCtB/UD2zhX45PyXbVgqElu0RK7fACmTEpncg4qEJNCCZBega5UpA1xdp
         +o7H9sIrgj7x8aoGp42aTLuQBBuaiAjBQGxVuc1CR6vSxKRIwjErpJiHp3Pyd0ExsWyF
         TuVKT7huDZFLLcclK0DfVTO4eBq4WCpE/IBthJwbiVvnmCipKBZMGFmIv6vWqGHKoeEf
         xOyg==
X-Gm-Message-State: AJIora9D3D8XkBpF0uyF5DvZdoSW+gu5kghs+9ovGnAUKuaLhvI4wWR+
        HUlSK2HgyOHAqW7p+cLCsTBBxsF5MYoLCkbN7jQ=
X-Google-Smtp-Source: AGRyM1vfqQUz9H1InKhz9W6PY+t2oH5IjHZq7FdqQtzL6mT1pXfeYlcbQosnKg/guNFZX6wu0eHD7+51EVONBU2ExpY=
X-Received: by 2002:a67:c11b:0:b0:349:cd63:997c with SMTP id
 d27-20020a67c11b000000b00349cd63997cmr4438859vsj.45.1655286594743; Wed, 15
 Jun 2022 02:49:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:cca4:0:b0:2ca:c25b:8ff9 with HTTP; Wed, 15 Jun 2022
 02:49:53 -0700 (PDT)
Reply-To: tescobank093.de@gmail.com
From:   Tesco Bank <uchennaezeemmanuel91@gmail.com>
Date:   Wed, 15 Jun 2022 10:49:53 +0100
Message-ID: <CAKuz1sW97CWnVrb-+THznR1AMr5ZGj9MThVAQsd7-hVW9=5RNA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--=20
Ben=C3=B6tigen Sie heute dringend einen Kredit, um eine Investition zu
t=C3=A4tigen? Ein neues Unternehmen gr=C3=BCnden oder Rechnungen bezahlen? =
Und
uns auf Wunsch in Raten zur=C3=BCckzahlen? Wir bieten Kredite zu einem sehr
niedrigen Zinssatz von 2% an. Wie viel Kredit m=C3=B6chten Sie??
