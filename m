Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09894600D8D
	for <lists+cgroups@lfdr.de>; Mon, 17 Oct 2022 13:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJQLQT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Oct 2022 07:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiJQLQQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Oct 2022 07:16:16 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4535F981
        for <cgroups@vger.kernel.org>; Mon, 17 Oct 2022 04:16:16 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id c22so12202150lja.6
        for <cgroups@vger.kernel.org>; Mon, 17 Oct 2022 04:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h6TAvh2KhlPwZbZl975on9cPhNtC4Qh0FGtOTBu2EFs=;
        b=gef9b3AUbM1jxHBI3J2IgkZLbPMxgVy7XmwCxNmb2IBJBxWu3hZAyt+3MjPgPB+Wx2
         PdrI80xY3gMdc9slDOov4IoH+Sp9T1OR4WcOE9KNy+OCHcxolCAQY4HgTFlzmjSH08DF
         fEc9oO3JaVO60ni+KxewqI14/TVKiPydmQBsCpS+ZUqZgyjMxYSd7dxDfgqaW3HBiETZ
         ejKOOQ/KOkyT35oD5TqOJQYytQwNIrbfsKzqaF8rIMtamb5Q6pf6S0QdyF3uuPimHh0a
         PKCvokqGIe31BFghP//nOuFdyZQ9xuPhTYYtyDJwiI70b5Kjj0pkAOG1VnfdrZ9kKL1w
         4O9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h6TAvh2KhlPwZbZl975on9cPhNtC4Qh0FGtOTBu2EFs=;
        b=T6SHqKNsO+W+DdfQ6d9UtJsvrko2E1vsRQDm2NRCOshUEop7yhR+0lfufrtvQWn8uy
         is72fQ6aYfe7QgYX0AhKoc3WqLKk32silPHmo02cHRaGnQL3e1dyyq4M7DsqkkjqzB/N
         Vlhrp7QWP/J0VFdwN6B3igXaAb4E85ruNU2lHKl8SLQkDdfXWH7UeCaJUN/dQd7NX/Nv
         vbsZZtcaYdIkTH1NuH35IKYE+440J3Ans0uGN9YOucYIU81n8PctBIwu/gcZGcadlAp3
         Rhf52p0L1bPd7GtM+UXHEfyEQ1BbY+TPM2+OgX+aiTlj3pX6yBMg8QsoIa0SOwa9r1OT
         ssSg==
X-Gm-Message-State: ACrzQf2FngIiaeu/5YyyEH67FDpQXC1z53k8u0ZwXeZtJ4pMC4OqPS85
        uiD3dgp+azpxZU2tzgsja3GdCjP2uf1AJ8hc65a4n7t2nkycEA==
X-Google-Smtp-Source: AMsMyM7W22dR4R/9ZWFE7rFWHbFW/An8xEhuCN+rCfC642k1ysd1JquoABPWibAhNv6v8cuJU8/FjiFR5g7MjikMiG4=
X-Received: by 2002:a17:906:65c6:b0:73c:8897:65b0 with SMTP id
 z6-20020a17090665c600b0073c889765b0mr8311585ejn.322.1666005363403; Mon, 17
 Oct 2022 04:16:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:71a:0:b0:1df:c5cd:1b43 with HTTP; Mon, 17 Oct 2022
 04:16:02 -0700 (PDT)
From:   M Cheickna Toure <metraoretk5@gmail.com>
Date:   Mon, 17 Oct 2022 12:16:02 +0100
Message-ID: <CACw7F=bjFM_a7nU=sYTn61huSMhQ+==ovsGxuT_=o-NmGEakwQ@mail.gmail.com>
Subject: Hello, Good morning
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,
Good morning and how are you?
I have an important and favourable information/proposal which might
interest you to know,
let me hear from you to detail you, it's important
Sincerely,
M.Cheickna
tourecheickna@consultant.com
