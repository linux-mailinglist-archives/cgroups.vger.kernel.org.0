Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0EA707AE6
	for <lists+cgroups@lfdr.de>; Thu, 18 May 2023 09:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjERHbJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 May 2023 03:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjERHbI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 May 2023 03:31:08 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9029E2D5F
        for <cgroups@vger.kernel.org>; Thu, 18 May 2023 00:29:54 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51f6461af24so1111542a12.2
        for <cgroups@vger.kernel.org>; Thu, 18 May 2023 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684394945; x=1686986945;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=TwiXvTszjrnBv2gQx4yO1sr1z9Oa7ZhwlWV3V0xzzFI3HZIUjd4YRzYWDDlM4YUMBA
         2e7YnGHPHgBcVl5eWO5RmPJefSOZqIoUK0QlLjlBhv1a2z1EiFh1anCExjlewt0ULgPI
         /uo37Ii+Sbj5s0H6pN+nb921QuAwa/wQy3nIpjp7wv1KEUzq++JIGLXkUt5tdsHwzVv+
         4BVaDL+bNda06c4hOQNgq7gegfKDvxveSZHYwBHXz0AJAFHnEzIFMfUlveU7yIrD85aJ
         5T/LcEw5qGss1KPGvZPKcXpKqlV4Ql3cAzO7rQB8W8HourXiqJCLReuK4uxfKZh1bQ+D
         +4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394945; x=1686986945;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=b2G/LZofVE7aN4k1VcKteGSAJCeI1YUFCHrSpctmJC2MtLGceWbhOoeITsR30ZItY4
         UGaOOgIb5hXQWhkd2ndVDE57WK43jD4cz/vvI6QdqP3+4WhyJN5sr4Sy4eFg5b6ht0bG
         yZX7h+wAg+mUMk7oGd0Hdo35Im5jSxSqkGswuTcTv1b6vOGMuybXy6iGhZ0f+Xj8uqwa
         uNaIKhQF3u2+FaH7a4iNmviDgO4D1aEywrGBSyH3FQ692EjNIrKOHa2FPeuVFVnt3tQI
         jWnedVHHqWpcJ5JI5Cc8Dx1ucL6k3myWFhAqXWkfMOYXvKS6kqCO4sUMCkzrgiWfVi0B
         uPOw==
X-Gm-Message-State: AC+VfDxQk9HYkClPOOniTj9tlBR7ZujQsPplgqZfUrSdLshQyBRxEIrb
        aRcGChF5zRNnqMcsohz+Q8H88bxmx7MR/oIfuH8=
X-Google-Smtp-Source: ACHHUZ5FX3bQwiMMM9ta2RAmPaEmhTu5KKvZu0O2Rw2KOCGeMbAKagyp0eupcZrzkZyJT4zYGmpJTvQWV5a5rCSmh0s=
X-Received: by 2002:a17:903:24c:b0:1ad:fcdc:bcb9 with SMTP id
 j12-20020a170903024c00b001adfcdcbcb9mr1860299plh.23.1684394944764; Thu, 18
 May 2023 00:29:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:e108:b0:470:f443:15ec with HTTP; Thu, 18 May 2023
 00:29:03 -0700 (PDT)
Reply-To: contact.ninacoulibaly@inbox.eu
From:   nina coulibaly <ninacoulibaly30.info@gmail.com>
Date:   Thu, 18 May 2023 00:29:03 -0700
Message-ID: <CAFb7D3dE12nke=z9KpcfN3ZXsLtV3KsrbrFku519oBPpM4YL6A@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear,

I am interested to invest with you in your country with total trust
and i hope you will give me total support, sincerity and commitment.
Please get back to me as soon as possible so that i can give you my
proposed details of funding and others.

Best Regards.

Mrs Nina Coulibaly
