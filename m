Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563B71F7DD8
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2020 21:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgFLT4n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Jun 2020 15:56:43 -0400
Received: from mout.web.de ([212.227.17.12]:59691 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFLT4m (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 12 Jun 2020 15:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591991788;
        bh=7m9D9uhJfOvU9oe94bssZb6aR8Jdd/LzEcEotEJw5yk=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=jydBlfmeg01uwJWgOzAOuRWcCTz6EvIm3Q8XbSAAS/l3/6eHbylqiY8da+ZZoRes3
         f86KaY6beCOIQcv2M9MFBP7VuFWmzgK/8WDNllH8OcXuOuUJxB3QUgv4CTkA+aOFH/
         y1zKL+ipnjX8uVVC8ZXnvW/E9Z+v3EoMXoZvCtKg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.95.40]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEXi-1jfS4B3tpI-00DIdq; Fri, 12
 Jun 2020 21:56:28 +0200
To:     weifenghai <zzuedu2000@163.com>, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Fix code style in css_task_iter_next_css_set()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <52681580-7ab4-a73c-6c86-bc9872de4fe8@web.de>
Date:   Fri, 12 Jun 2020 21:56:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W+sZCJ0djnSI6RvRfvd7Owm0DUz5XUjc8d0gcm8AUEktIhH+1R/
 a1SriapME/FQa7Lm9qsTivFic/wTaxZ5DGxOZJVF7GNo0dQnBs+mhFF4cRlHRcyKu1I0ZP1
 vsAqISwDqvX++pnoQkELeLqfxcgF7xulwVRn5zvJg9yTNJjK4RJwqTuDpY33IOgSINi6Gd7
 617GYymyTjVH6w2BBdXrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tvAGkxyYkZg=:NUAfDZ4qSPPGOM3UIuMsb4
 9s2xn22t50seXERsgZFyonJ/wy2Aiblqu4ZOeVY/cxsvmw1UOXSxCBkWfSsUuYgMYChW9Lksw
 gRI2RtZmj9LJbxiS2sZmgiSSOZqrK8ypyNHqDKwTzvBmjqLhLaYsi1LLYrgkN4I78lJudkI7O
 0HQw1As7pjIqQKDnQB/HfmpAiz06je5PRponiHsWXOkij4Gq8As2bNRwIPO2j1Cf1a73Qe7Nr
 9H9N1FfrXKA2j5d9zER+2qm5EqtsviIQODTUezyJxjsixcb5dZPBVySsVkNem3PN6/475AaBL
 xnTUf9AaWhLlA3YQWON++lHIdIiJ6Z/ZeEkQuP0oyKms9Ufc4lBxwPyLm44MWVw+4/FcR/NYT
 uuvVQexqGBrKReplscLL0RN0CzVXS5RALqBWUjdzxG6IK0dZ+aZaqiGFUwLFeCHp5HbXEINiD
 F7RsIVkkd7Vhpjt/CS+PQu5y0972IH5M2WXLXGwe1sLwWzWqBcC+66w+ejc3MMF/PkZCAXEwm
 RIBEmoj93feV6lMXSMUhMWpdHXX2J9ucPEHCVn6v/Yy8EOM6gK6RYOgvgRVNdbp09vFW9MpBE
 obXtFlAXzoPgWfBy1cHLAO/XXdTl28nE14khLAvvn3dcZPZbOy33Ot+dlT2cpU0XWPFnF/RZN
 T/x3EZsqMoOGKg1BqDv0Sh0qkGX7v6SC/VgCE5Kcq6fBkdAS+Q+XKRnXIqluzoRfOVITnlPUM
 VsibIYY8qNzN23LyAx/9swZeH9TXENUpt+DbAzDuO06ERHPz6TZty6cuBVEzgqaOZ/8qxdO0a
 RtYvV/m6zxIFYYwJGVYZ15VvVabgb31ACaJiLGpFWkjNIP9BdQLgHM7B0HlD5SiqSxLzx79gj
 7sYW2ZafXFtLM+BJowQ/yvfbl2WIvSPjeBfum9iGpQr5yvyqMv5ygueZ15qKVpEYXNSdXWA27
 alY3xpZ+Q0Qn5KNexue2OfbaJMwZwh9dEJEF1VG8KBaYiaavjmqLo0b3plIvYvjpLci0gCHgE
 My4tYcHM76GGtgYVfMENbFCHtU046142mq7/N95m8NKGVQu3d0xah2w0AAaq4idaz9uK5Svs/
 remAlSMlHRdWhlSgx2Bhw0JM+L+oVW2aL4Jsd+CH+BN4s1uCKN7RlAWySn4yl8wGN4WUMH531
 qM0CvLdlYAnrV81+LsRQWCqR2KXoRFzATT/DIeioJcbkOiQt5LUVr2Qw49YenRG54uHvqSjx6
 TFwdRgDA/6x+RWMOg
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> One line similar code before in this function

I suggest to improve the commit message.
How do you think about a wording variant like the following?

   Combine two assignments for the variable =E2=80=9Cl=E2=80=9D into one s=
tatement.

Regards,
Markus
